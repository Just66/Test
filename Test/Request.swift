//
//  Request.swift
//  Test
//
//  Created by Dmytro Aprelenko on 18.07.2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation
import UIKit

struct Item: Codable {
    let itemId: String?
    let name: String?
    let image: String?
    let description: String?
    let time: String?
    
    var date: String {
        guard let timeInterval = Double(time ?? "") else {return NSLocalizedString("Unrecognized date", comment: "")}
        let date = Date(timeIntervalSince1970: timeInterval / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd-MMMM-yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}

class Request {
    static let instance = Request()
    
    func getData(comletion: @escaping (_ items: [Item]?, _ error: Error?) -> ()) {
        guard let url = URL(string: "http://test.php-cd.attractgroup.com/test.json") else { return }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if error != nil {
                comletion(nil, error)
                return
            }
            guard let data = data else {
                comletion(nil, error)
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse else {
                comletion(nil, error)
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    let decoder = JSONDecoder()
                    let decode = try decoder.decode([Item].self, from: data)
                    
                    comletion(decode, nil)
                } catch let jsonError {
                    comletion(nil, jsonError)
                    print(jsonError)
                }
            default:
                print(error?.localizedDescription)
                comletion(nil, error)
            }
            }.resume()
    }
}
