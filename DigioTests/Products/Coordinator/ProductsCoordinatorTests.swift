//
//  ProductsCoordinatorTests.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 26/11/24.
//

import XCTest
@testable import Digio

class ProductsCoordinatorTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var coordinator: ProductsCoordinator!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        mockNetworkService = MockNetworkService()
        coordinator = ProductsCoordinator(navigationController: navigationController, networkService: mockNetworkService)
    }
    
    override func tearDown() {
        navigationController = nil
        coordinator = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testStart() {
        coordinator.start()
        XCTAssertTrue(navigationController.viewControllers.first is ProductListViewController, "Root view controller should be ProductListViewController")
    }
    
    func testShowProductDetails() {
        let product = ProductItem(name: "Test Product", imageURL: "https://example.com/image.png", description: "Test Description")
        coordinator.showProductDetails(for: product)
        XCTAssertTrue(navigationController.viewControllers.last is ProductDetailsViewController, "Last view controller should be ProductDetailsViewController")
    }
}
