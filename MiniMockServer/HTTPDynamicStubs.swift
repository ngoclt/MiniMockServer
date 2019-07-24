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

public class HTTPDynamicStubs {
    
    var server = HttpServer()
    
    open func setUp(_ stubs: [HTTPStubInfo]?) {
        if let stub = stubs {
            setupInitialStubs(stub)
        }
        
        try! server.start()
    }
    
    open func tearDown() {
        server.stop()
    }
    
    public func setupInitialStubs(_ stubs: [HTTPStubInfo]) {
        // Setting up all the initial mocks from the array
        for stub in stubs {
            setupStub(path: stub.path,
                      method: stub.method,
                      header: stub.header,
                      statusCode: stub.statusCode,
                      response: stub.response)
        }
    }
    
    public func setupStub(path: String,
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
        
        
        // Swifter makes it very easy to create stubbed responses
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
    
    public func setupStub(path: String, redirect: String, method: HTTPMethod = .GET) {
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
    
    public func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}

public struct HTTPStubInfo {
    var path: String
    var method: HTTPMethod
    var header: [String: String]?
    var statusCode: Int = 200
    var response: HTTPStubResponse? = nil
    
    init(path: String,
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
    case successFile(file: String)
    case successObject(object: [String: Any])
    case error(rootCause: String, errorMessage: String)
    
    var jsonData: Data? {
        switch self {
        case .successFile(let file):
            if let filePath = Bundle.current.path(forResource: file, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                return try? Data(contentsOf: fileUrl, options: .uncached)
            }
            return nil
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
