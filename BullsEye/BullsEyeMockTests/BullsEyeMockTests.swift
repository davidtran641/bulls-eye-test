//
//  BullsEyeMockTests.swift
//  BullsEyeMockTests
//
//  Created by Tran Duc on 5/18/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye

class MockUserDefaults: UserDefaults {
    var gameStyleChanged = 0
    override func set(_ value: Int, forKey defaultName: String) {
        if defaultName == "gameStyle" {
            gameStyleChanged += 1
        }
    }
}

class BullsEyeMockTests: XCTestCase {
    var controllerUnderTest: ViewController!
    var mockUserDefaults: MockUserDefaults!

    override func setUp() {
        super.setUp()
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController
        mockUserDefaults = MockUserDefaults(suiteName: "testing")!
        controllerUnderTest.defaults = mockUserDefaults
    }

    override func tearDown() {
        controllerUnderTest = nil
        mockUserDefaults = nil
        super.tearDown()
    }

    func testGameStyleCanBeChanged() {
        // given
        let segmentedControl = UISegmentedControl()

        // when
        XCTAssertEqual(mockUserDefaults.gameStyleChanged, 0)
        segmentedControl.addTarget(controllerUnderTest, action: #selector(ViewController.chooseGameStyle(_:)), for: .valueChanged)
        segmentedControl.sendActions(for: .valueChanged)

        // then
        XCTAssertEqual(mockUserDefaults.gameStyleChanged, 1)
    }

}
