//
//  HalfTunesSlowTests.swift
//  HalfTunesSlowTests
//
//  Created by Tran Duc on 5/18/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import HalfTunes

class HalfTunesSlowTests: XCTestCase {

    var sessionUnderTest: URLSession!

    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }


    func test_whenValidCallToiTunes_thenGetsHTTPStatus200() {
        // given
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")!
        let promise = expectation(description: "Status code 200")
        var statusCode: Int?
        var responseError: Error?

        // when
        let dataTask = sessionUnderTest.dataTask(with: url) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()

        // wait
        waitForExpectations(timeout: 5, handler: nil)

        // then
        XCTAssertEqual(statusCode, 200)
        XCTAssertNil(responseError)

    }

}

