//
//  DataCell.swift
//  Test
//
//  Created by Dmytro Aprelenko on 18.07.2018.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet weak var imgView: ImageWithCache!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var item: Item? {
        didSet {
            guard let item = item else {return}
            
            titleLbl.text = item.name
            dateLbl.text = item.date
            
            imgView.loadImageUsingUrlString(item.image ?? "")
        }
    }
}
