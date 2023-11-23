//
//  HighlightTableViewCell.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 21/11/23.
//

import UIKit

class HighlightTableViewCell: UITableViewCell {

    private lazy var highlightImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var title: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0

        return label
    }()

    private lazy var subtitle: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()

    private lazy var actionButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Compre agora", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)

        return button
    }()

    func setupCell(title: String, subtitle: String, image: UIImage?) {

        contentView.backgroundColor = backgroundColor
        highlightImageView.image = image
        self.title.text = title
        self.subtitle.text = subtitle
        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {

        contentView.addSubview(highlightImageView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        contentView.addSubview(actionButton)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            highlightImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            highlightImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            highlightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            highlightImageView.heightAnchor.constraint(equalToConstant: 350),

            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.topAnchor.constraint(equalTo: highlightImageView.bottomAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actionButton.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
