//
//  NetworkService.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//


import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case httpError(statusCode: Int)
    case invalidData
    case decodingError(Error)
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endPoint: APIEndpointProtocol, completion: @escaping (Result<T, Error>) -> Void)
}

struct NetworkService: NetworkServiceProtocol {
    
    func request<T: Decodable>(_ endPoint: APIEndpointProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endPoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidRequest))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.httpError(statusCode: httpResponse.statusCode)))
                return
            }
    
            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        
        task.resume()
    }
}
