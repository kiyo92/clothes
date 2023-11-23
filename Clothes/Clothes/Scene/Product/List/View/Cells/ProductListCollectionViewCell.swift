//
//  ProductListCollectionViewCell.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 23/11/23.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {

    private lazy var imageContainerView: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var discountContainerView: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "F2F2F2")
        view.isHidden = true

        return view
    }()

    private lazy var discountLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)

        return label
    }()

    private lazy var productImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var productNameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var productDescriptionLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var productPriceLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private lazy var productPriceWithDiscountLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)

        return label
    }()

    func setupCell(image: Data?,
                   productName: String?,
                   productDescription: String?,
                   productPrice: String?,
                   productPriceWithDiscount: String?,
                   discountRate: String? = nil,
                   onSale: Bool? = nil) {

        var productImage: UIImage?

        if let image {

            productImage = UIImage(data: image)
        } else {

            productImage = UIImage(named: "noImage")
        }

        productImageView.image = productImage
        productNameLabel.text = productName
        productDescriptionLabel.text = productDescription
        productPriceLabel.text = productPrice

        if let discountRate = discountRate,
           onSale == true {

            discountContainerView.isHidden = false
            discountLabel.text = "\(discountRate) off"


            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: productPrice ?? "")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                             value: 2, range: NSRange(location: 0,
                                                                      length: attributeString.length))

            productPriceLabel.attributedText = attributeString
            productPriceLabel.layer.opacity = 0.7
            productPriceWithDiscountLabel.text = productPriceWithDiscount
        }

        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {

        contentView.addSubview(imageContainerView)
        imageContainerView.addSubview(productImageView)
        imageContainerView.addSubview(discountContainerView)
        discountContainerView.addSubview(discountLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productDescriptionLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(productPriceWithDiscountLabel)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageContainerView.heightAnchor.constraint(equalToConstant: 200),
            imageContainerView.widthAnchor.constraint(equalToConstant: contentView.frame.width),

            discountContainerView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            discountContainerView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),

            discountLabel.leadingAnchor.constraint(equalTo: discountContainerView.leadingAnchor, constant: 4),
            discountLabel.topAnchor.constraint(equalTo: discountContainerView.topAnchor, constant: 4),
            discountLabel.trailingAnchor.constraint(equalTo: discountContainerView.trailingAnchor, constant: -4),
            discountLabel.bottomAnchor.constraint(equalTo: discountContainerView.bottomAnchor, constant: -4),

            productImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            productImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),

            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productNameLabel.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            productDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            productPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productPriceLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 4),
            productPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            productPriceWithDiscountLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 4),
            productPriceWithDiscountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productPriceWithDiscountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
