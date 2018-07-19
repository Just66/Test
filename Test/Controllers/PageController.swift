//
//  PageController.swift
//  Test
//
//  Created by Dmytro Aprelenko on 18.07.2018.
//  Copyright © 2018 Test. All rights reserved.
//


import UIKit

class PageController: UIPageViewController, UIPageViewControllerDelegate {
    
    var pagesOfData = [Item]()
    var indexToStart: Int = 0
    
    weak var navBtnDelegate: NavigationBtnDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(back(notification:)), name: .previous, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(forward(notification:)), name: .next, object: nil)
        
        
        
        let initialContenViewController = self.pageAtIndex(indexToStart) as! ContentVC
        self.setViewControllers([initialContenViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
        UIPageControl.appearance().currentPageIndicatorTintColor = .green
    }
    
    @objc func back(notification: NSNotification) {
        goToPreviousPage()
    }
    @objc func forward(notification: NSNotification) {
        goToNextPage()
    }
    
    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) as? ContentVC else { return }
        guard let index = nextViewController.pageIndex else { return }
        self.navBtnDelegate?.btns(backBtn: index == 0, forwardBtn: pagesOfData.count == index + 1)
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
    }
    
    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) as? ContentVC else { return }
        guard let index = previousViewController.pageIndex else { return }
        self.navBtnDelegate?.btns(backBtn: index == 0, forwardBtn: pagesOfData.count == index + 1)
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
    }
}


extension PageController: UIPageViewControllerDataSource
{
    func pageAtIndex(_ index: Int) -> ContentVC
    {
        let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "ContentOfData") as! ContentVC
        
        contentVC.customData = pagesOfData[index]
        contentVC.pageIndex = index
        
        return contentVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ContentVC
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index -= 1
        
        return self.pageAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ContentVC
        var index = viewController.pageIndex as Int
        
        if((index == NSNotFound))
        {
            return nil
        }
        
        index += 1
        
        if(index == pagesOfData.count)
        {
            return nil
        }
        
        return self.pageAtIndex(index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return pagesOfData.count
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        let vc = pageViewController.viewControllers?.first as? ContentVC
        guard let index = vc?.pageIndex else { return 0 }
        return index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            if let pageViewController = pageViewController.viewControllers!.first! as? ContentVC {
                if let index = pageViewController.pageIndex {
                    self.navBtnDelegate?.btns(backBtn: index == 0, forwardBtn: pagesOfData.count == index + 1)
                }
            }
            
        }
    }
}



