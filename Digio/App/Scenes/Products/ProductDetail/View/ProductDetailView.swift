//
//  ProductDetailView.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 25/11/24.
//

import UIKit

class ProductDetailView: UIView {
    
    var onActionButtonTapped: (() -> Void)?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [image, title, productDescription])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.font = .preferredFont(forTextStyle: .title1)
        title.textColor = UIColor(named: "PrimaryColor")
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var productDescription: UILabel = {
        let description = UILabel()
        description.font = .preferredFont(forTextStyle: .body)
        description.textColor = .gray
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        return description
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Comprar", for: .normal)
        button.backgroundColor = UIColor(named: "PrimaryColor")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleActionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    
    func configure(with product: CollectionItem) {
        if let url = URL(string: product.imageURL) {
            image.loadImage(from: url)
        }
        title.text = product.name
        productDescription.text = product.description
    }
    
    @objc private func handleActionButtonTapped() {
        onActionButtonTapped?()
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints do scrollView
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Constraints do contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Constraints do stackView
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Constraints da imagem
            image.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            // Constraints do título
            title.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            // Constraints da descrição
            productDescription.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            productDescription.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            // Constraints do botão
            actionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
