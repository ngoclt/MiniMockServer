//
//  ListVolumesPresenterTests.swift
//  GBookTests
//
//  Created by Extra Computer on 10/05/2019.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import XCTest

@testable import MiniMockServerExample

class ListVolumesPresenterTests: XCTestCase {
    
    var presenter: ListVolumesPresenter!
    
    override func setUp() {
        super.setUp()
        presenter = ListVolumesPresenter()
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func testRatingText_returnAverageRating() {
        guard let volume: Volume = VolumeTestCases.validVolumeJSON.object() else {
            XCTFail("Faking json data is incorrect")
            return
        }
        
        XCTAssertEqual(presenter.ratingText(for: volume), "4.0")
    }
    
    func testPublisherText_returnCorrectText() {
        guard let volume: Volume = VolumeTestCases.validVolumeJSON.object() else {
            XCTFail("Faking json data is incorrect")
            return
        }
        
        XCTAssertEqual(presenter.publisherText(for: volume).string, "Published by: Pottermore Publishing")
    }
}
