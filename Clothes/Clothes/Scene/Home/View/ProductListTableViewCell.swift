//
//  ProductListTableViewCell.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 21/11/23.
//

import UIKit

protocol ProductListTableViewCellDelegate: AnyObject {

    func productWasSelected(product: Product)
    func goToProductList()
}

class ProductListTableViewCell: UITableViewCell {

    weak var delegate: ProductListTableViewCellDelegate?

    private var productList: [Product] = []

    private lazy var seeMore: UIButton = {

        let button = UIButton(
            primaryAction: UIAction { [weak self] _ in
                guard let self else { return }
                delegate?.goToProductList()
            })
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ver mais", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)

        return button
    }()

    private lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: "ProductListCollectionViewCell")

        return collectionView
    }()

    func setupCell(productList: [Product]) {

        collectionView.delegate = self
        collectionView.dataSource = self
        self.productList = productList
        setupHierarchy()
        setupContraints()
        collectionView.reloadData()
    }

    func setupHierarchy() {

        contentView.addSubview(seeMore)
        contentView.addSubview(collectionView)
    }

    func setupContraints() {

        NSLayoutConstraint.activate([

            seeMore.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            seeMore.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: seeMore.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension ProductListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

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

        delegate?.productWasSelected(product: productList[indexPath.item])
    }
}

extension ProductListTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: contentView.frame.width / 1.8, height: 290)
    }
}
