//
//  CartViewController.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 24/11/23.
//

import UIKit

class CartViewController: UIViewController {

    let viewModel: CartViewModel = CartViewModel()

    let tableView: UITableView = {

        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartProductTableViewCell.self, forCellReuseIdentifier: "CartProductTableViewCell")

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.productList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductTableViewCell",
                                                       for: indexPath) as? CartProductTableViewCell
        else { return UITableViewCell () }

        cell.setupCell(product: viewModel.productList[indexPath.row])

        return cell
    }
}
