//
//  HalfTunesMockTests.swift
//  HalfTunesMockTests
//
//  Created by Tran Duc on 5/18/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import HalfTunes

class HalfTunesMockTests: XCTestCase {

    var controllerUnderTest: SearchViewController!

    override func setUp() {
        super.setUp()
        controllerUnderTest = UIStoryboard(name: "Main",
                                           bundle: nil).instantiateInitialViewController() as! SearchViewController
        controllerUnderTest.loadView()

        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "abbaData", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)

        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)

        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)

        controllerUnderTest.defaultSession = sessionMock

    }

    override func tearDown() {
        controllerUnderTest = nil
        super.tearDown()
    }

    func test_whenUpdateTestResult_thenParsesData() {
        // given
        let promise = expectation(description: "Status code: 200")

        var resData: Data?
        var statusCode: Int?
        var resError: Error?
        // when
        XCTAssertEqual(controllerUnderTest.searchResults.count, 0)
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")!
        let dataTask = controllerUnderTest.defaultSession.dataTask(with: url) { (data, response, error) in
            resError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            resData = data
            promise.fulfill()
        }

        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        controllerUnderTest.updateSearchResults(resData)

        // then
        XCTAssertEqual(statusCode, 200)
        XCTAssertNil(resError)
        XCTAssertEqual(controllerUnderTest.searchResults.count, 3)

    }

    func test_startDownload_performance() {
        let track = Track(name: "Waterloo", artist: "ABBA", previewUrl: "http://a821.phobos.apple.com/us/r30/Music/d7/ba/ce/mzm.vsyjlsff.aac.p.m4a")
        measure {
            self.controllerUnderTest.startDownload(track)
        }
    }


}

