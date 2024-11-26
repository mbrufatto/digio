//
//  NetworkServiceTests.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 26/11/24.
//

import XCTest
@testable import Digio

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    var mockURLSession: MockURLSession!
    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        mockURLSession = MockURLSession()
        urlSession = mockURLSession
        networkService.urlSession = urlSession
    }
    
    override func tearDown() {
        super.tearDown()
        urlSession = nil
    }
    
    func testRequestSuccess() {
        // Arrange
        let endPoint = ProductsAPIEndpoint.products
        let expectedData = """
            {
                "spotlight": [
                    {
                        "name": "Spotlight 1",
                        "bannerURL": "https://example.com/spotlight1",
                        "description": "Descrição do Spotlight 1"
                    }
                ],
                "products": [
                    {
                        "name": "Produto 1",
                        "imageURL": "https://example.com/produto1",
                        "description": "Descrição do Produto 1"
                    }
                ],
                "cash": {
                    "title": "Cash",
                    "bannerURL": "https://example.com/cash",
                    "description": "Descrição do Cash"
                }
            }
            """.data(using:.utf8)!
        mockURLSession.data = expectedData
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.error = nil

        // Act
        var result: Result<Products, Error>?
        let expectation = XCTestExpectation(description: "Wait for request to complete")
        networkService.request(endPoint) {
            result = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)

        // Assert
        if case.success(let products) = result {
            XCTAssertEqual(products.spotlight.count, 2)
            XCTAssertEqual(products.products.count, 3)
            XCTAssertNotNil(products.cash)
        } else {
            XCTFail("Resultado não é um sucesso")
        }
    }

    func testRequestFailureInvalidRequest() {
        // Arrange
        let endPoint = ProductsAPIEndpoint.invalidRequest
        
        // Act
        var result: Result<[String], Error>?
        let expectation = XCTestExpectation(description: "Wait for request to complete")
        networkService.request(endPoint) {
            result = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
        // Assert
        if case.failure(let error) = result {
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidRequest)
        } else {
            XCTFail("Resultado não é um erro")
        }
    }
    
    func testRequestFailureHTTPError() {
        // Arrange
        let endPoint = ProductsAPIEndpoint.products
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        
        // Act
        var result: Result<[String], Error>?
        let expectation = XCTestExpectation(description: "Wait for request to complete")
        networkService.request(endPoint) {
            result = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
        // Assert
        if case.failure(let error) = result {
            if case.httpError(let statusCode) = error as! NetworkError {
                XCTAssertEqual(statusCode, 404)
            } else {
                XCTFail("Erro não é um httpError")
            }
        } else {
            XCTFail("Resultado não é um erro")
        }
    }
    
    func testRequestFailureDecodingError() {
        // Arrange
        let endPoint = ProductsAPIEndpoint.products
        mockURLSession.data = "Dados inválidos".data(using:.utf8)!
        
        // Act
        var result: Result<[String], Error>?
        let expectation = XCTestExpectation(description: "Wait for request to complete")
        networkService.request(endPoint) {
            result = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
        // Assert
        if case.failure(let error) = result {
            if case.decodingError(_) = error as! NetworkError {
                XCTFail("Erro não é um decodingError")
            }
        } else {
            XCTFail("Resultado não é um erro")
        }
    }
}
