//
//  APIEndpoit.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//

import Foundation

enum HTTPMethod: String {
    case get
}

protocol APIEndpointProtocol {
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var url: URL? { get }
}

extension APIEndpointProtocol {
    var url: URL? {
        URL(string: APICofiguration.baseURL + (path ?? ""))
    }
}
