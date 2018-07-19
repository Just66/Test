//
//  Extension.swift
//  Test
//
//  Created by Dmytro Aprelenko on 18.07.2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func sizeClass() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
        return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
    }
}

extension Notification.Name {
    static let previous = Notification.Name ("previous")
    static let next = Notification.Name ("nextPage")
}
