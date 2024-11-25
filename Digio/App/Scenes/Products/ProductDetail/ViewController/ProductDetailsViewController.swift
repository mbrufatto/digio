//
//  ProductDetailsViewController.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 25/11/24.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    private let productDetailView = ProductDetailView()
    private let viewModel: ProductDetailViewModel
    private let coordinator: ProductsCoordinatorProtocol
    
    init(viewModel: ProductDetailViewModel, coordinator: ProductsCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = viewModel.getProduct() {
            productDetailView.configure(with: product)
        }
        
        productDetailView.onActionButtonTapped = { [weak self] in
            self?.handleActionButtonTapped()
        }
    }
    
    override func loadView() {
        view = productDetailView
    }
    
    private func handleActionButtonTapped() {
        guard let product = viewModel.getProduct() else { return }
        coordinator.didTapBuyButton(for: product)
    }
}
