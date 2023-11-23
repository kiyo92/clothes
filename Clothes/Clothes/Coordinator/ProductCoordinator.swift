//
//  ProductCoordinator.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 21/11/23.
//

import Foundation
import UIKit

class ProductCoordinator: Coordinator {

    weak var parent: Coordinator?
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

    func start() {}

    func start(productList: [Product], saleFilter: Bool = false) {

        let vc = ProductListViewController(productList: productList)
        vc.coordinator = self
        vc.title = saleFilter ? "SALE" : "CLOTHES"
        self.navigationController.pushViewController(vc, animated: true)
    }

    func productDetail(with product: Product) {

        let vc = ProductDetailViewController(product: product)
        vc.title = "CLOTHES"
        self.navigationController.pushViewController(vc, animated: true)
    }

    func dismissChildCoordinator (with child: Coordinator?) {

        for (index, coordinator) in children.enumerated() {

            if child === coordinator {

                children.remove(at: index)
                break
            }
        }
    }
}
