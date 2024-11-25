//
//  ProductsAPIEndpoint.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//


enum ProductsAPIEndpoint: APIEndpointProtocol {
    case products

    var path: String {
        switch self {
        case .products:
            return "/products"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String]? {
        nil
    }
}
