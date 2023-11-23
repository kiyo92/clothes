//
//  ProductListViewController.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 21/11/23.
//

import UIKit

class ProductListViewController: UIViewController {

    private var productList: [Product]
    weak var coordinator: ProductCoordinator?

    private lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductListCollectionViewCell.self,
                                forCellWithReuseIdentifier: "ProductListCollectionViewCell")

        return collectionView
    }()

    init(productList: [Product]) {

        self.productList = productList
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .white
        setupHierarchy()
        setupConstraints()
        collectionView.reloadData()
    }

    func setupHierarchy() {

        view.addSubview(collectionView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return productList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell",
                                                            for: indexPath) as? ProductListCollectionViewCell
        else { return UICollectionViewCell() }

        let product = productList[indexPath.item]
        cell.setupCell(image: product.imageData,
                       productName: product.name,
                       productDescription: "Descrição mockada",
                       productPrice: product.regular_price,
                       productPriceWithDiscount: product.actual_price,
                       discountRate: product.discount_percentage,
                       onSale: product.on_sale)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        coordinator?.productDetail(with: productList[indexPath.row])
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width / 2.5, height: 270)
    }
}
