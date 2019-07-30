//
//  HTTPDynamicStubs.swift
//  WhimComponentUITests
//
//  Created by Ngoc Le on 16/07/2019.
//  Copyright © 2019 maas. All rights reserved.
//

import Foundation
import Swifter

public enum HTTPMethod {
    case POST
    case GET
    case PUT
    case DELETE
}

open class HTTPDynamicStubs {
    
    private var server = HttpServer()
    
    open func setUp(_ stubs: [HTTPStubInfo]?) {
        if let stub = stubs {
            setupInitialStubs(stub)
        }
        
        try! server.start()
    }
    
    open func tearDown() {
        server.stop()
    }
    
    open func setupInitialStubs(_ stubs: [HTTPStubInfo]) {
        // Setting up all the initial mocks from the array
        for stub in stubs {
            setupStub(path: stub.path,
                      method: stub.method,
                      header: stub.header,
                      statusCode: stub.statusCode,
                      response: stub.response)
        }
    }
    
    open func setupStub(path: String,
                          method: HTTPMethod = .GET,
                          header: [String: String]? = nil,
                          statusCode: Int = 200,
                          response: HTTPStubResponse? = nil) {
        
        var responseData: Data
        if let data = response?.jsonData {
            responseData = data
        } else {
            responseData = "{}".data(using: .utf8)!
        }
        
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            return HttpResponse.raw(statusCode, "OK", header, { try $0.write(responseData) })
        }
        
        switch method {
        case .GET :
            server.GET[path] = response
        case .POST:
            server.POST[path] = response
        case .PUT:
            server.PUT[path] = response
        case .DELETE:
            server.DELETE[path] = response
        }
    }
    
    open func setupStub(path: String, redirect: String, method: HTTPMethod = .GET) {
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            .movedPermanently(redirect)
        }
        
        switch method {
        case .GET :
            server.GET[path] = response
        case .POST:
            server.POST[path] = response
        case .PUT:
            server.PUT[path] = response
        case .DELETE:
            server.DELETE[path] = response
        }
    }
    
    open func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}

public struct HTTPStubInfo {
    public let path: String
    public let method: HTTPMethod
    public let header: [String: String]?
    public let statusCode: Int
    public let response: HTTPStubResponse?
    
    public init(path: String,
         method: HTTPMethod,
         header: [String: String]? = nil,
         statusCode: Int = 200,
         response: HTTPStubResponse? = nil) {
        self.path = path
        self.response = response
        self.method = method
        self.header = header
        self.statusCode = statusCode
    }
}

public enum HTTPStubResponse {
    case successFile(fileUrl: URL)
    case successObject(object: Any)
    case error(rootCause: String, errorMessage: String)
    
    public var jsonData: Data? {
        switch self {
        case .successFile(let fileUrl):
            return try? Data(contentsOf: fileUrl, options: .uncached)
        case .successObject(let object):
            return try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        case .error(let rootCause, let errorMessage):
            let errorObject: [String: Any] = [
                "statusCode" : 401,
                "rootCause" : rootCause,
                "errorMessage" : errorMessage
            ]
            return try? JSONSerialization.data(withJSONObject: errorObject, options: .prettyPrinted)
        }
        
    }
}
