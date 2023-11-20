//
//  RouteModel.swift
//  Clothes
//
//  Created by João Marcus Dionisio Araujo on 19/11/23.
//

import Foundation

struct RouteModel {

    enum HTTPMethod: String {

        case get
        case post
    }

    let headers: [String: String]?
    let method: HTTPMethod?
    let path: PathProtocol
    let parameters: [String: Any]?
    let queryParameters: [URLQueryItem]?

    init(path: PathProtocol,
         headers: [String: String]? = nil,
         method: HTTPMethod? = .get,
         parameters: [String: Any]? = nil,
         queryParameters: [URLQueryItem]? = nil) {

        self.path = path
        self.headers = headers
        self.method = method
        self.parameters = parameters
        self.queryParameters = queryParameters
    }
}
