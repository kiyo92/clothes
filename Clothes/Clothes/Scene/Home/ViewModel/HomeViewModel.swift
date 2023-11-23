//
//  HomeViewModel.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 23/11/23.
//

import Foundation

class HomeViewModel {

    var adapter: NetworkAdapter = NetworkAdapter(routeModel: RouteModel(path: ProductPath(path: .productList)))
    private var group: DispatchGroup = DispatchGroup()
    private(set) var productList: [Product] = []

    func getProductList(completion: @escaping() -> Void) async {

        await adapter.request(with: ProductModel.self, isRemote: false) { [weak self] data, _ in

            guard let self else { return }
            productList = data?.products ?? []

            for (index, product) in productList.enumerated() {

                group.enter()
                getProductImage(product: product, index: index)
            }
        }

        group.notify(queue: .global()) {
            completion()
        }
    }

    func getProductImage(product: Product, index: Int) {

        let routeModel = RouteModel(path: CustomPath(absolutePath: product.image ?? ""))
        let adapter = NetworkAdapter(routeModel: routeModel)

        adapter.request { [weak self] data, _, _ in

            guard let self else { return }

            productList[index].imageData = data
            group.leave()
        }
    }
}
