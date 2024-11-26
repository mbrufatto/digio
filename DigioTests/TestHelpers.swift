//
//  TestHelpers.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 26/11/24.
//

import XCTest

func anyError() -> Error {
    NSError(domain: "com.example.error", code: 0, userInfo: nil)
}

func wait(for timeout: TimeInterval) {
    let expectation = XCTestExpectation(description: "Wait for \(timeout) seconds")
    DispatchQueue.main.asyncAfter(deadline:.now() + timeout) {
        expectation.fulfill()
    }
    XCTWaiter().wait(for: [expectation], timeout: timeout + 1)
}
