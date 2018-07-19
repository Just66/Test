//
//  DetailedVC.swift
//  Test
//
//  Created by Dmytro Aprelenko on 18.07.2018.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    
    var items = [Item]()
    var currentIndex = 0
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func back(_ sender:
        Any) {
        NotificationCenter.default.post(name: .previous, object: nil)
    }
    
    @IBAction func forward(_ sender: Any) {
        NotificationCenter.default.post(name: .next, object: nil)
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPageVC"{
            if let pageVC = segue.destination as? PageController {
                pageVC.navBtnDelegate = self
                pageVC.pagesOfData = items
                pageVC.indexToStart = currentIndex
            }
        }
    }
    
}

extension DetailedVC: NavigationBtnDelegate {
    func btns(backBtn: Bool, forwardBtn: Bool) {
        self.backBtn?.isHidden = backBtn
        self.forwardBtn?.isHidden = forwardBtn
    }
    
    
}
