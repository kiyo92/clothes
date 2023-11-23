//
//  ProductSizeCollectionViewCell.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 23/11/23.
//

import UIKit

class ProductSizeCollectionViewCell: UICollectionViewCell {

    private lazy var sizeLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()


    func setupCell(size: String, isAvailable: Bool) {

        sizeLabel.text = size

        contentView.backgroundColor = isAvailable ? .white : .lightGray
        contentView.layer.borderColor = isAvailable ? UIColor.black.cgColor : UIColor.clear.cgColor
        contentView.layer.borderWidth = isAvailable ? 1 : 0
        contentView.layer.opacity = isAvailable ? 1 : 0.5
        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {

        contentView.addSubview(sizeLabel)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            sizeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sizeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
