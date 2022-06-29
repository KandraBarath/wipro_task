//
//  TaskTests.swift
//  TaskTests
//
//  Created by apple on 29/06/22.
//

import XCTest
@testable import Task

class TaskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_HomeApiResponse_ValidReturns() {
        
        let viewModel = HomeViewModel()
        let exceptions = self.expectation(description: "HomeApiResponse")
        
        viewModel.getCanadaDetails { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertNotEqual(data.title, "")
                XCTAssertNotEqual(data.rows.count, 10)
            case.failure(let error):
                XCTAssertNil(error)
            }
            exceptions.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
