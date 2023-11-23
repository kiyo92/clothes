//
//  ProductPath.swift
//  Clothes
//
//  Created by João Marcus Dionisio Araujo on 19/11/23.
//

import Foundation

class ProductPath: PathProtocol {

    enum Path {

        case productList
    }

    let path: Path

    init(path: Path) {

        self.path = path
    }

    func getPath() -> String {

        switch path {

        case .productList:
            
            guard let path = Bundle.main.path(forResource: "productList", ofType: "json") else { return "" }

            return path
        }
    }
}
