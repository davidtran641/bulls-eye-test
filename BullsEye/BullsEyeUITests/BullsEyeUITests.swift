//
//  BullsEyeUITests.swift
//  BullsEyeUITests
//
//  Created by Tran Duc on 5/18/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import XCTest

class BullsEyeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testGameStyleSwitch() {

        // given

        let slideButton = app.segmentedControls/*@START_MENU_TOKEN@*/.buttons["Slide"]/*[[".segmentedControls.buttons[\"Slide\"]",".buttons[\"Slide\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let typeButton = app.segmentedControls/*@START_MENU_TOKEN@*/.buttons["Type"]/*[[".segmentedControls.buttons[\"Type\"]",".buttons[\"Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let slideLabel = app.staticTexts["Get as close as you can to: "]
        let typeLabel = app.staticTexts["Guess where the slider is: "]

        // then
        if slideButton.isSelected {
            XCTAssertTrue(slideLabel.exists)
            XCTAssertFalse(typeLabel.exists)

            typeButton.tap()
            XCTAssertFalse(slideLabel.exists)
            XCTAssertTrue(typeLabel.exists)
        } else if typeButton.isSelected {
            XCTAssertFalse(slideLabel.exists)
            XCTAssertTrue(typeLabel.exists)

            slideButton.tap()
            XCTAssertTrue(slideLabel.exists)
            XCTAssertFalse(typeLabel.exists)
        }

    }

}
