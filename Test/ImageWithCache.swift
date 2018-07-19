//
//  ImageWithCache.swift
//  Test
//
//  Created by Dmytro Aprelenko on 18.07.2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageWithCache: UIImageView {
    
    var imageUrlString: String?
    var session = URLSession.shared
    
    func loadImageUsingUrlString(_ urlString: String) {
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        session.dataTask(with: url!, completionHandler: { (data, respones, error) in
            
            guard error == nil else {return}
            guard let data = data else {return}
            
            DispatchQueue.main.async(execute: {
                guard let imageToCache = UIImage(data: data) else {return}
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
            })
            
        }).resume()
    }
    
}
