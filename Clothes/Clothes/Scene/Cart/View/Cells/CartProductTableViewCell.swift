//
//  CartProductTableViewCell.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 24/11/23.
//

import UIKit

class CartProductTableViewCell: UITableViewCell {

    private lazy var productImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var productNameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var productAmountLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var productSizeLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var totalPriceLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    func setupCell(product: CartProduct) {

        productImageView.image = UIImage(data: product.image ?? Data())
        productNameLabel.text = product.name
        productAmountLabel.text = "\(product.quantity ?? 0)"
        productSizeLabel.text = product.size

        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {

        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productAmountLabel)
        contentView.addSubview(productSizeLabel)
        contentView.addSubview(totalPriceLabel)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 75),
            productImageView.heightAnchor.constraint(equalToConstant: 100),

            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),

            productAmountLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 32),
            productAmountLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),

            productSizeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 32),
            productSizeLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),

            productSizeLabel.topAnchor.constraint(equalTo: productSizeLabel.bottomAnchor, constant: 32),
            productSizeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
