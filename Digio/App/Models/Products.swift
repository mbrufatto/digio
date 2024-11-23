//
//  Products.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//

import Foundation

struct Products: Decodable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}

struct Cash: Decodable {
    let title: String
    let bannerURL: String
    let description: String
}

struct Product: Decodable {
    let name: String
    let imageURL: String
    let description: String
}

struct Spotlight: Decodable {
    let name: String
    let bannerURL: String
    let description: String
}

