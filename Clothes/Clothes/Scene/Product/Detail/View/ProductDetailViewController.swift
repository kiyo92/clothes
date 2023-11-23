//
//  ProductDetailViewController.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 23/11/23.
//

import UIKit

class ProductDetailViewController: UIViewController {

    let product: Product

    private lazy var productImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var productNameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)

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

        return label
    }()

    private lazy var sizeLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Escolha um tamanho"
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
    }()

    private lazy var sizeCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductSizeCollectionViewCell.self, forCellWithReuseIdentifier: "ProductSizeCollectionViewCell")

        return collectionView
    }()

    init(product: Product) {
        
        self.product = product
        super.init(nibName: nil, bundle: nil)

        self.productImageView.image = UIImage(data: product.imageData ?? Data())
        self.productNameLabel.text = product.name
        self.productDescriptionLabel.text = "Uma descrição mockada para o produto"
        self.productPriceLabel.text = product.actual_price
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        view.backgroundColor = .white
        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {

        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(productDescriptionLabel)
        view.addSubview(productPriceLabel)
        view.addSubview(sizeLabel)
        view.addSubview(sizeCollectionView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 350),

            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            productDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            productPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productPriceLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 4),
            productPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            sizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sizeLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 16),
            sizeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            sizeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sizeCollectionView.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 8),
            sizeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sizeCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {

         return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return product.sizes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSizeCollectionViewCell",
                                                            for: indexPath) as? ProductSizeCollectionViewCell
        else { return UICollectionViewCell() }

        cell.setupCell(size: product.sizes?[indexPath.item].size ?? "",
                       isAvailable: product.sizes?[indexPath.item].available ?? false)

        return cell
    }
}

extension ProductDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 30, height: 30)
    }
}
