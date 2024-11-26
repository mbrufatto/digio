//
//  NetworkServiceTests.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 26/11/24.
//

import XCTest
@testable import Digio

class NetworkServiceTests: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
    }
    
    override func tearDown() {
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testRequestValidEndpoint() {
        mockNetworkService.shouldFail = false
        let endpoint = MockAPIEndpoint(path: "/valid", method: .get)
        let expectation = self.expectation(description: "Valid Request")
        
        mockNetworkService.request(endpoint) { (result: Result<Products, Error>) in
            switch result {
            case .success(let products):
                XCTAssertNotNil(products, "Products should not be nil")
                XCTAssertEqual(products.spotlight.first?.name, "Spotlight Product", "The spotlight product name should match")
                XCTAssertEqual(products.cash.title, "Cash", "The cash title should match")
            case .failure(let error):
                XCTFail("Request failed with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testRequestInvalidEndpoint() {
        mockNetworkService.shouldFail = true
        let endpoint = MockAPIEndpoint(path: "/invalid", method: .get)
        let expectation = self.expectation(description: "Invalid Request")
        
        mockNetworkService.request(endpoint) { (result: Result<Products, Error>) in
            switch result {
            case .success:
                XCTFail("Request should not succeed")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
