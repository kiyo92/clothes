//
//  PromotionalBannerTableViewCell.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 21/11/23.
//

import UIKit

class PromotionalBannerTableViewCell: UITableViewCell {

    private lazy var title: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white

        return label
    }()

    func setupCell(title: String, backgroundColor: UIColor = .black) {

        contentView.backgroundColor = backgroundColor
        self.title.text = title
        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {
        contentView.addSubview(title)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
