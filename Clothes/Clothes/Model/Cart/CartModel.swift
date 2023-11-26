//
//  CartModel.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 24/11/23.
//

import Foundation

struct CartModel: Codable {

    var products: [CartProduct]?
}

struct CartProduct: Codable {

    var name: String?
    var quantity: Int?
    var price: String?
    var size: String?
    var image: Data?
}
