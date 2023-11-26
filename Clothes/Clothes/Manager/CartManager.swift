//
//  CartManager.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 24/11/23.
//

import Foundation

class CartManager {

    static var manager = CartManager()
    private var cart: CartModel = CartModel(products: [])

    func getProductList() -> [CartProduct] {

        return cart.products ?? []
    }

    func addProduct(productCard: CartProduct) {

        cart.products?.append(productCard)
    }

    func removeProduct(at index: Int) {

        cart.products?.remove(at: index)
    }
}
