//
//  XCTestExtensions.swift
//  WhimComponentUITests
//
//  Created by Ngoc Le on 16/07/2019.
//  Copyright © 2019 maas. All rights reserved.
//

import XCTest

public extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
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
    
    internal func scrollUpToElement(_ element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    internal func scrollDownToElement(_ element: XCUIElement) {
        while !element.visible() {
            swipeDown()
        }
    }
    
    internal func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
    
    internal func forceTapElement() {
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

extension Bundle {
    static var current: Bundle {
        class __ { }
        return Bundle(for: __.self)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromXCUIKeyboardKey(_ input: XCUIKeyboardKey) -> String {
    return input.rawValue
}
