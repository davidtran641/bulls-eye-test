//
//  BullsEyeTests.swift
//  BullsEyeTests
//
//  Created by Tran Duc on 5/18/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye

class BullsEyeTests: XCTestCase {
    var gameUnderTest: BullsEyeGame!

    override func setUp() {
        gameUnderTest = BullsEyeGame()
        gameUnderTest.startNewGame()
    }

    override func tearDown() {
        gameUnderTest = nil
    }

    func testScoreIsComputed() {
        // given
        let guess = gameUnderTest.targetValue + 5

        // when
        _ = gameUnderTest.check(guess: guess)

        // then
        XCTAssertEqual(gameUnderTest.scoreRound, 95)
    }

    func testScoreLessThanTarget() {
        // given
        let guess = gameUnderTest.targetValue - 5

        // when
        _ = gameUnderTest.check(guess: guess)

        // then
        XCTAssertEqual(gameUnderTest.scoreRound, 95)
    }
    
}


