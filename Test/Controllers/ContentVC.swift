//
//  ContentVC.swift
//  Test
//
//  Created by Dmytro Aprelenko on 18.07.2018.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {

    
    @IBOutlet weak var imageView: ImageWithCache!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descritprionLbl: UILabel!
    
    var pageIndex: Int!
    var customData: Item! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let item = customData else {return}
        
        titleLbl.text = item.name ?? "No name"
        dateLbl.text = item.date
        descritprionLbl.text = item.description ?? "No Description"
        
        imageView.loadImageUsingUrlString(item.image ?? "")
    }

}
