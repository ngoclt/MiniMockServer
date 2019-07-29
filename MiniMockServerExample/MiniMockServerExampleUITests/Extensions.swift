//
//  Extensions.swift
//  MiniMockServerExampleUITests
//
//  Created by Ngoc Le on 26/07/2019.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import XCTest

extension XCUIElement {

    func clearAndEnterText(_ text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        let hasKeyboardFocus = (self.value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        if !hasKeyboardFocus {
            self.tap()
        }
        
        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        self.typeText(deleteString)
        self.typeText(text)
    }
    
    func longPress() {
        self.press(forDuration: 0.6)
    }
    
    func scrollToElement(_ element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
    
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
            coordinate.tap()
        }
    }
}

extension XCTestCase {
    
    func waitForElementToAppear(_ element: XCUIElement, timeout: Double = 10) -> Bool {
        return waitForCondition("exists == true", with: element, timeout: timeout)
    }
    
    func waitForElementToBeHittable(_ element: XCUIElement, timeout: Double = 10) -> Bool {
        return waitForCondition("isHittable == true", with: element, timeout: timeout)
    }
    
    func waitForCondition(_ condition: String, with element: XCUIElement, timeout: Double = 10) -> Bool {
        let predicate = NSPredicate(format: condition)
        let exp = expectation(for: predicate, evaluatedWith: element, handler: nil)
        let result = XCTWaiter().wait(for: [exp], timeout: timeout)
        return result == .completed
    }
}

