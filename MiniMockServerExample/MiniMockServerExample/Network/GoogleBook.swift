//
//  GoogleBook.swift
//  MiniMockServerExample
//
//  Created by Ngoc LE on 2/25/19.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import Foundation
import Moya

enum GoogleBook {
    case search(query: String)
    case volume(volumeId: String)
}


extension GoogleBook: TargetType {
    
    public var baseURL: URL {
        if let server = self.mockServer {
            return URL(string: server)!
        }
        
        return URL(string: "https://www.googleapis.com/books/v1")!
    }
    
    public var path: String {
        switch self {
        case .search: return "/volumes"
        case .volume(let volumeId): return "/volumes/\(volumeId)"
        }
    }
    
    
    
    public var method: Moya.Method {
        switch self {
        case .search: return .get
        case .volume: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .search(let query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.default)
        case .volume:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    public var mockServer: String? {
        return ProcessInfo.processInfo.environment["MOCK_SERVER_URL"]
    }
}
