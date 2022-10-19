//
//  APIManager.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import Foundation

protocol RestAPIProviderProtocol {
    func getSearchResults(for string: String, completionHandler: @escaping(SearchResult) -> Void)
    func sendLoginNumber(for string: String, completionHandler: @escaping(LoginModel) -> Void)
}

class APIManager: RestAPIProviderProtocol {
    func sendLoginNumber(for string: String, completionHandler: @escaping (LoginModel) -> Void) {
        
        let endpoint = Endpoint.sendNumberForLogin(number: string)
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let login = try decoder.decode(LoginModel.self, from: data)
                 completionHandler(login)
                } catch let error {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
    
    
    func getSearchResults(for string: String, completionHandler: @escaping (SearchResult) -> Void) {
        
        let endpoint = Endpoint.getSearchResults(key: string)
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let searchResult = try decoder.decode(SearchResult.self, from: data)
                 completionHandler(searchResult)
                } catch let error {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
    
    
}

enum Endpoint {
    case getSearchResults(key: String)
    case sendNumberForLogin(number: String)
}

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
        }
    }
}

