//
//  MockNetworkService.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 26/11/24.
//

import Foundation


class MockNetworkService: NetworkServiceProtocol {
    var shouldFail = false
    
    func request<T: Decodable>(_ endPoint: APIEndpointProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        if shouldFail {
            completion(.failure(NetworkError.invalidRequest))
        } else {
            let mockData = """
            {
                "spotlight": [{"name": "Spotlight Product", "bannerURL": "https://example.com/banner.png", "description": "Test Description"}],
                "cash": {"title": "Cash", "bannerURL": "https://example.com/banner.png", "description": "Cash Description"},
                "products": [{"name": "Product 1", "imageURL": "https://example.com/image1.png", "description": "Description 1"},
                             {"name": "Product 2", "imageURL": "https://example.com/image2.png", "description": "Description 2"}]
            }
            """.data(using: .utf8)!
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(T.self, from: mockData)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
