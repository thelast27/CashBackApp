//
//  Endpoint+Extension.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 25.10.22.
//

import Foundation
import UIKit

extension Endpoint {
    var utCoinURL: String {
        return "https://utcoin.one/loyality/search?search_string="
    }
    
    var loginURL: String{
        return "https://utcoin.one/loyality/login_step1?phone="
    }
    
    var url: URL {
        switch self {
        case .getSearchResults(let key):
            if let url = URL(string: utCoinURL.appending("\(key)")) {
                return url
            }
            fatalError()
            
        case .sendNumberForLogin(number: let number):
            if let url = URL(string: loginURL.appending("\(number)")) {
                return url
            }
            fatalError()
        case .getMoreResults(key: let key, number: let number):
            if let url = URL(string: utCoinURL.appending("\(key)&page=\(number)")) {
                return url
            }
            fatalError()
        }
    }
}

