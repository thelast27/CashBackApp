//
//  LoginModel.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 19.10.22.
//

import Foundation

struct LoginModel: Codable {
    let successful: Bool?
    let errorMessage, errorMessageCode: String?
    let settings: JSONNull?
    let normalizedPhone, explainMessage: String?
}


