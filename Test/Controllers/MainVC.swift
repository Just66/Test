//
//  MainVC.swift
//  Test
//
//  Created by Dmytro Aprelenko on 18.07.2018.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuLeading: NSLayoutConstraint!
    
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var mainTableView: UIView!
    @IBOutlet weak var fakeListView: UIView!
    
    @IBOutlet weak var menuTableView: UITableView!
    
    
    var menuIsOpened: Bool = false {
        didSet {
            menuLeading.constant = menuIsOpened ? 0 : -150
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        self.navigationItem.title = NSLocalizedString("Main", comment: "")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureView()
    }
    
    func configureView() {
        switch self.sizeClass() {
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
            self.navigationItem.leftBarButtonItems?.removeAll()
        default:
            let selectedBtn = UIBarButtonItem(title: NSLocalizedString("Menu", comment: ""), style: .done, target: self, action: #selector(callMenu))
            self.navigationItem.setLeftBarButton(selectedBtn, animated: false)
        }
        
    }
    
    @objc func callMenu() {
        menuIsOpened = !menuIsOpened
    }

}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = NSLocalizedString("Main", comment: "")
        case 1:
            cell.textLabel?.text = NSLocalizedString("List of items", comment: "")
        case 2:
            cell.textLabel?.text = NSLocalizedString("Settings", comment: "")
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            settingsView.isHidden = true
            mainTableView.isHidden = false
            fakeListView.isHidden = true
            self.navigationItem.title = NSLocalizedString("Main", comment: "")
        case 1:
            settingsView.isHidden = true
            mainTableView.isHidden = true
            fakeListView.isHidden = false
            self.navigationItem.title = NSLocalizedString("List of Items", comment: "")
        case 2:
            settingsView.isHidden = false
            mainTableView.isHidden = true
            fakeListView.isHidden = true
            self.navigationItem.title = NSLocalizedString("Settings", comment: "")
        default: break
        }
        menuIsOpened = false
    }
    
}



