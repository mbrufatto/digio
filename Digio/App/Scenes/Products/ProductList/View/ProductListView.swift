//
//  ProductsView.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//

import UIKit

class ProductListView: UIView {
    
    var onProductSelected: ((ProductItem) -> Void)?
    
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var welcome: UILabel = {
        let label = UILabel()
        label.text = "Olá, Maria"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupConstraints()
    }
    
    func setup() {
        backgroundColor = .white
        addSubview(logo)
        addSubview(welcome)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logo.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            logo.widthAnchor.constraint(equalToConstant: 42),
            logo.heightAnchor.constraint(equalToConstant: 42),
            
            welcome.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            welcome.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 16),
            welcome.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func update(with products: Products?) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
