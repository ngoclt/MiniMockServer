//
//  GoogleBookAPI.swift
//  MiniMockServerExample
//
//  Created by Ngoc LE on 2/26/19.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import Foundation
import Moya

class GoogleBookAPI: GoogleBookProtocol {
    
    func searchVolume(query: String, completionHandler: @escaping ([Volume], Error?) -> Void) {
        let provider = MoyaProvider<GoogleBook>(plugins: [NetworkLoggerPlugin()])
        provider.request(.search(query: query)) { result in
            
            switch result {
            case .success(let response):
                do {
                    let items = try response.map(ListItemResponse<Volume>.self).items
                    completionHandler(items, nil)
                } catch {
                    print(error)
                    completionHandler([], error)
                }
            case .failure(let error):
                completionHandler([], error)
            }
        }
    }
    
    func fetchBook(id: String, completionHandler: @escaping (Volume, Error?) -> Void) {
        
    }
}
