//
//  ProductModel.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 23/11/23.
//

import Foundation

struct ProductModel: Codable {

    var products: [Product]?
}

struct Product: Codable {

    var name: String?
    var color: String?
    var on_sale: Bool?
    var regular_price: String?
    var actual_price: String?
    var discount_percentage: String?
    var installments: String?
    var image: String?
    var imageData: Data?
    var sizes: [ProductSize]?
}

struct ProductSize: Codable {

    var available: Bool?
    var size: String?
}
