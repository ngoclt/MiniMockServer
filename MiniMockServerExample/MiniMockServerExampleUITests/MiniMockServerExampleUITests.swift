//
//  MiniMockServerExampleUITests.swift
//  MiniMockServerExampleUITests
//
//  Created by Ngoc Le on 25/07/2019.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import XCTest
import MiniMockServer

class MiniMockServerExampleUITests: MockableTestCase {
    
    override func initialStubs() -> [HTTPStubInfo]? {
        let fakeVolumes: [[String: Any]] = []
        return [
            HTTPStubInfo(path: "/volumes?q=Harry%20Potter",
                         method: .GET,
                         response: .successObject(object: fakeVolumes))
        ]
    }

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "search_books", withExtension: "json") else {
            XCTFail("Mock file is not exist.")
            return
        }
        
        stub(path: "/volumes?q=mockserver", response: .successFile(fileUrl: fileUrl))
        
        let textFieldSearch = app.textFields["textFieldSearch"]
        XCTAssert(waitForElementToAppear(textFieldSearch))
        textFieldSearch.clearAndEnterText("mockserver")
        
        textFieldSearch.typeText(XCUIKeyboardKey.return.rawValue)
        
        let collectionView = app.collectionViews.element(boundBy: 0)
        let firstCell = collectionView.cells.element(boundBy: 0)
        XCTAssert(waitForElementToAppear(firstCell))
        
        let publisherLabel = firstCell.staticTexts["publisherLabel"]
        XCTAssertEqual(publisherLabel.label, "Published by: Mock Server")
    }

}
