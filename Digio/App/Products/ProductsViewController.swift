//
//  ProductsViewController.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//

import UIKit

class ProductsViewController: UIViewController {
    
    private let productsView = ProductsView()
    private let viewModel: ProductsViewModelProtocol
    private let coordinator: ProductsCoordinatorProtocol
    
    init(viewModel: ProductsViewModelProtocol, coordinator: ProductsCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = productsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        viewModel.fetchProducts()
    }
    
    private func setupTableView() {
        productsView.tableView.delegate = self
        productsView.tableView.dataSource = self
        productsView.tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.reuseIdentifier)
    }
    
    private func setupBindings() {
        viewModel.onProductsUpdated = { [weak self] in
            self?.productsView.update(with: self?.viewModel.products ?? nil)
        }
        
        viewModel.onError = { [weak self] error in
            self?.showError(error.localizedDescription)
        }
        
        productsView.onProductSelected = { [weak self] product in
            self?.coordinator.showProductDetails(for: product)
        }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let products = viewModel.products else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.reuseIdentifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: products.spotlight.map { CollectionItem(name: $0.name, imageURL: $0.bannerURL, description: $0.description) }, title: "")
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.reuseIdentifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: [CollectionItem(name: products.cash.title, imageURL: products.cash.bannerURL, description: products.cash.description)], title: "Digio Cash")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.reuseIdentifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: products.products.map { CollectionItem(name: $0.name, imageURL: $0.imageURL, description: $0.description) }, title: "Produtos")
            return cell
        }
    }
}
