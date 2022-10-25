//
//  String+Extesnion.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 25.10.22.
//

import Foundation
import UIKit

extension String {
    
    func stringToImage(_ handler: @escaping (UIImage?) -> () ) {
        if let url = URL(string: self) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    handler(image)
                }
            }.resume()
        }
    }
}
