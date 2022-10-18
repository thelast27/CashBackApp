//
//  APIManager.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import Foundation

protocol RestAPIProviderProtocol {
    func getSearchResults(for string: String, completionHandler: @escaping(SearchResult) -> Void)
}

class APIManager: RestAPIProviderProtocol {
    
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
                    let currentWeather = try decoder.decode(SearchResult.self, from: data)
                 completionHandler(currentWeather)
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
}

extension Endpoint {
    var utCoinURL: String {
        return "https://utcoin.one/loyality/search?search_string="
    }
    
    var url: URL {
        switch self {
        case .getSearchResults(let key):
            if let url = URL(string: utCoinURL.appending("\(key)")) {
                return url
            }
            fatalError()
        }
    }
}

