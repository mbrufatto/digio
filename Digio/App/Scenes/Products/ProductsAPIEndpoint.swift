//
//  ProductsAPIEndpoint.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//

enum ProductsAPIEndpoint: APIEndpointProtocol {
    case products
    case invalidURL
    case invalidRequest
    case invalidData

    var path: String? {
        switch self {
        case.products:
            return "/products"
        case.invalidURL:
            return nil
        case .invalidRequest,.invalidData:
            return "/invalid-data"
        }
    }

    var method: HTTPMethod {
       .get
    }

    var headers: [String: String]? {
        nil
    }
}
