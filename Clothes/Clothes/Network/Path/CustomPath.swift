//
//  CustomPath.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 23/11/23.
//

import Foundation

class CustomPath: PathProtocol {

    private var path: String

    init(absolutePath: String) {

        self.path = absolutePath
    }

    func getPath() -> String {

        return self.path
    }
}
