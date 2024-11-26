//
//  MockAPIEndpoint.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 26/11/24.
//

struct MockAPIEndpoint: APIEndpointProtocol {
    var path: String
    var method: HTTPMethod
    var headers: [String: String]? = nil
}
