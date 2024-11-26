//
//  ProductListViewModelTests.swift
//  DigioTests
//
//  Created by Marcio Habigzang Brufatto on 26/11/24.
//

import XCTest
@testable import Digio

class ProductListViewModelTests: XCTestCase {
    
    var viewModel: ProductListViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = ProductListViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchProductsSuccess() {
        let expectation = self.expectation(description: "Products Fetched Successfully")
        
        viewModel.onProductsUpdated = {
            XCTAssertNotNil(self.viewModel.products, "Products should not be nil")
            XCTAssertEqual(self.viewModel.products?.products.count, 2, "Should fetch 2 products")
            expectation.fulfill()
        }
        
        viewModel.fetchProducts()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchProductsFailure() {
        mockNetworkService.shouldFail = true
        let expectation = self.expectation(description: "Products Fetch Failed")
        
        viewModel.onError = { error in
            XCTAssertNotNil(error, "Error should not be nil")
            expectation.fulfill()
        }
        
        viewModel.fetchProducts()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
