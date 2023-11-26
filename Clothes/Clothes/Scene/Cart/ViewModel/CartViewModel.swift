//
//  CartViewModel.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 26/11/23.
//

import Foundation

class CartViewModel {

    private let cart = CartManager.manager
    var productList: [CartProduct] = []

    func getProductList() -> [CartProduct] {

        productList = cart.getProductList()
        return cart.getProductList()
    }
}
