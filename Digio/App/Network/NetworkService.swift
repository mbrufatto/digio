//
//  NetworkService.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//
import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidRequest
    case httpError(statusCode: Int)
    case invalidData
    case decodingError(Error)
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL,.invalidURL): return true
        case (.invalidRequest,.invalidRequest): return true
        case (.httpError(let lhsStatusCode),.httpError(let rhsStatusCode)): return lhsStatusCode == rhsStatusCode
        case (.invalidData,.invalidData): return true
        case (.decodingError,.decodingError): return true
        default: return false
        }
    }
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endPoint: APIEndpointProtocol, completion: @escaping (Result<T, Error>) -> Void)
}

struct NetworkService: NetworkServiceProtocol {
    
    var urlSession: URLSession = URLSession.shared
    
    func request<T: Decodable>(_ endPoint: APIEndpointProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endPoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.headers
        
        let task = urlSession.dataTask(with: request) { data, response, error in
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
            
            guard let data = try? Data(contentsOf: url) else {
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
