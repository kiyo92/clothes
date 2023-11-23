//
//  HomeCoordinator.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 21/11/23.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {

    weak var parent: Coordinator?
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

    func start() {

        let vc = HomeViewController()
        vc.coordinator = self
        vc.title = "CLOTHES"
        self.navigationController.navigationBar.barTintColor = .white
        self.navigationController.navigationBar.tintColor = .black
        self.navigationController.pushViewController(vc, animated: true)
    }

    func productList(with productList: [Product], saleFilter: Bool = false) {

        let child = ProductCoordinator(navigationController: self.navigationController)
        child.parent = self
        children.append(child)
        child.start(productList: productList, saleFilter: saleFilter)
    }

    func productDetail(with product: Product) {

        let child = ProductCoordinator(navigationController: self.navigationController)
        child.parent = self
        children.append(child)
        child.productDetail(with: product)
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
