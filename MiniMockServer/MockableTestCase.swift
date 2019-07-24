//
//  MockableTestCase.swift
//  WhimComponentUITests
//
//  Created by Ngoc Le on 16/07/2019.
//  Copyright © 2019 maas. All rights reserved.
//

import XCTest

open class MockableTestCase: XCTestCase {
    
    let app = XCUIApplication()
    
    #if MOCKSERVER
    let dynamicStubs = HTTPDynamicStubs()
    #endif
    
    open func initialStubs() -> [HTTPStubInfo]? {
        return nil
    }
    
    open override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        #if MOCKSERVER
        app.launchEnvironment["UITestServer"] = "http://localhost:8080"
        
        let stubs = initialStubs()
        dynamicStubs.setUp(stubs)
        #endif
        
        app.launchArguments += ["UI-Testing"]
        app.launch()
    }
    
    open override func tearDown() {
        super.tearDown()
        app.launchArguments.removeAll()
        
        #if MOCKSERVER
        dynamicStubs.tearDown()
        #endif
    }
    
    public func stub(path: String,
              method: HTTPMethod = .GET,
              header: [String: String]? = nil,
              statusCode: Int = 200,
              response: HTTPStubResponse? = nil) {
        #if MOCKSERVER
        dynamicStubs.setupStub(path: path, method: method, header: header, statusCode: statusCode, response: response)
        #endif
    }
    
    public func stub(path: String, redirect: String, method: HTTPMethod = .GET) {
        #if MOCKSERVER
        dynamicStubs.setupStub(path: path, redirect: redirect, method: method)
        #endif
    }
    
    public func stub(_ stubs: [HTTPStubInfo]) {
        #if MOCKSERVER
        dynamicStubs.setUp(stubs)
        #endif
    }
}
