//
//  Router.swift
//  Clothes
//
//  Created by João Marcus Dionisio Araujo on 19/11/23.
//

import Foundation

class Router: RouteProtocol {

    private let route: RouteModel

    init(route: RouteModel) {

        self.route = route
    }

    func getRoute() -> RouteModel {

        return self.route
    }
}
