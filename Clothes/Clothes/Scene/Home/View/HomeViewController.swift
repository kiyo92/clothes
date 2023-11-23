//
//  HomeViewController.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 21/11/23.
//

import UIKit

class HomeViewController: UIViewController {

    enum HomeCellType {

        case promotionalBanner(title: String)
        case highlight(title: String, subtitle: String, image: UIImage?)
        case productList([Product])
    }

    private var viewModel: HomeViewModel = HomeViewModel()

    private var homeData: [HomeCellType] = []
    var coordinator: HomeCoordinator?

    private lazy var homeTableView: UITableView = {

        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PromotionalBannerTableViewCell.self, forCellReuseIdentifier: "PromotionalBannerTableViewCell")
        tableView.register(HighlightTableViewCell.self, forCellReuseIdentifier: "HighlightTableViewCell")
        tableView.register(ProductListTableViewCell.self, forCellReuseIdentifier: "ProductListTableViewCell")
        tableView.separatorStyle = .none

        return tableView
    }()

    override func viewDidLoad() {

        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        setupHierarchy()
        setupConstraints()
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white

        Task { [weak self] in

            guard let self else { return }
            homeData = []

            await viewModel.getProductList() {

                self.homeData.append(contentsOf: [.promotionalBanner(title: "20% de desconto em todos os produtos"),
                                                  .highlight(title: "Coleção de verão",
                                                             subtitle: "Uma seleção especial para o verão feita pelos maiores especialistas do mundo",
                                                             image: UIImage(named: "summerCover")),
                                                  .highlight(title: "Moda de luxo",
                                                             subtitle: "Oportunidades em sale durante a Black Week. 20% off",
                                                             image: UIImage(named: "luxuryCover"))])
                self.homeData.append(.productList(self.viewModel.productList))

                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }
            }
        }
    }

    func setupHierarchy() {

        view.addSubview(homeTableView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            homeTableView.topAnchor.constraint(equalTo: view.topAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return homeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch homeData[indexPath.row] {

        case .promotionalBanner(let title):

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionalBannerTableViewCell",
                                                           for: indexPath) as? PromotionalBannerTableViewCell
            else { return UITableViewCell() }

            cell.setupCell(title: title)

            return cell
        case .highlight(let title, let subtitle, let image):

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightTableViewCell",
                                                           for: indexPath) as? HighlightTableViewCell
            else { return UITableViewCell() }

            cell.selectionStyle = .none
            cell.setupCell(title: title, subtitle: subtitle, image: image)

            return cell
        case .productList(let productList):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell",
                                                           for: indexPath) as? ProductListTableViewCell
            else { return UITableViewCell() }

            cell.delegate = self
            cell.setupCell(productList: productList)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch homeData[indexPath.row] {

        case .promotionalBanner(_):

            var productList: [Product] = []
            self.viewModel.productList.forEach { product in

                if product.on_sale ?? false {
                    productList.append(product)
                }
            }
            coordinator?.productList(with: productList, saleFilter: true)

        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
}

extension HomeViewController: ProductListTableViewCellDelegate {

    func goToProductList() {
        
        coordinator?.productList(with: viewModel.productList)
    }

    func productWasSelected(product: Product) {

        coordinator?.productDetail(with: product)
    }
}
