//
//  NetworkAdapter.swift
//  Clothes
//
//  Created by João Marcus Dionisio Araujo on 19/11/23.
//

import Foundation

class NetworkAdapter {

    enum NetworkError: Error {
        case unabeToGenerateRequest
        case invalidEndpoint
        case parsingError
    }

    let route: RouteProtocol

    init(routeModel: RouteModel) {

        let route = Router(route: routeModel)
        self.route = route
    }

    func request<T:Decodable>(with type: T.Type,
                              isRemote: Bool = true,
                              completion: @escaping(T?, NetworkError?) -> Void) async {

        let requestConfigs = self.route.getRoute()
        var request: URLRequest
        let session = URLSession.shared

        if isRemote {

            var components = URLComponents()
            components.scheme = "https"
            components.host = "host"
            components.queryItems = requestConfigs.queryParameters
            components.path = requestConfigs.path.getPath()

            guard let url = components.url else { return }

            request = URLRequest(url: url)
            request.allHTTPHeaderFields = requestConfigs.headers
            request.httpMethod = requestConfigs.method?.rawValue.uppercased()

            let response = session.dataTask(with: request) { data, response, error in

                guard response != nil else {
                    completion(nil, .invalidEndpoint)
                    return
                }

                do {
                    let result = try JSONDecoder().decode(T.self, from: data ?? Data())
                    completion(result, nil)
                } catch {
                    completion(nil, .parsingError)
                }
            }

            response.resume()

        } else {

            do {

                let data = try Data(contentsOf: URL(fileURLWithPath: requestConfigs.path.getPath()))
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            } catch {
                
                completion(nil, .parsingError)
            }
        }
    }

    func request(completion: @escaping(Data?, URLResponse?, Error?) -> Void) {

        let requestConfigs = self.route.getRoute()
        if let imageUrl = URL(string: requestConfigs.path.getPath()) {
            
            URLSession.shared.dataTask(with: imageUrl, completionHandler: completion).resume()
        } else {
            completion(nil, nil, nil)
        }
    }
}
