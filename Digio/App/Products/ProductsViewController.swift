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
        setupBindings()
        viewModel.fetchProducts()
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
