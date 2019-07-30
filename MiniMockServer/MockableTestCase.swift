//
//  MockableTestCase.swift
//  MiniMockServer
//
//  Created by Ngoc Le on 16/07/2019.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import XCTest

open class MockableTestCase: XCTestCase {
    
    public static let kMiniMockServerURLKey = "MOCK_SERVER_URL"
    
    public let app = XCUIApplication()
    
    private let dynamicStubs = HTTPDynamicStubs()
    
    open func initialStubs() -> [HTTPStubInfo]? {
        return nil
    }
    
    open override func setUp() {
        super.setUp()
        
        app.launchEnvironment[MockableTestCase.kMiniMockServerURLKey] = "http://localhost:8080"
        
        let stubs = initialStubs()
        dynamicStubs.setUp(stubs)
        
        app.launch()
    }
    
    open override func tearDown() {
        super.tearDown()
        app.launchArguments.removeAll()
        
        dynamicStubs.tearDown()
    }
    
    public func stub(path: String,
              method: HTTPMethod = .GET,
              header: [String: String]? = nil,
              statusCode: Int = 200,
              response: HTTPStubResponse? = nil) {
        dynamicStubs.setupStub(path: path, method: method, header: header, statusCode: statusCode, response: response)
    }
    
    public func stub(path: String, redirect: String, method: HTTPMethod = .GET) {
        dynamicStubs.setupStub(path: path, redirect: redirect, method: method)
    }
    
    public func stub(_ stubs: [HTTPStubInfo]) {
        dynamicStubs.setUp(stubs)
    }
}
