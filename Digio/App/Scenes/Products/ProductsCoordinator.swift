//
//  ProductsCoordinator.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 23/11/24.
//
import UIKit

protocol ProductsCoordinatorProtocol: AnyObject {
    func start()
    func showProductDetails(for product: CollectionItem)
    func didTapBuyButton(for product: CollectionItem)
}

class ProductsCoordinator: ProductsCoordinatorProtocol {
    private let navigationController: UINavigationController
    private let networkService: NetworkServiceProtocol
    
    init(navigationController: UINavigationController, networkService: NetworkServiceProtocol) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    func start() {
        let viewModel = ProductListViewModel(networkService: networkService)
        let productsViewController = ProductListViewController(viewModel: viewModel, coordinator: self)
        navigationController.setViewControllers([productsViewController], animated: false)
    }
    
    func showProductDetails(for product: CollectionItem) {
        let viewModel = ProductDetailViewModel(product: product)
        let productDetailsViewController = ProductDetailsViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(productDetailsViewController, animated: true)
    }
    
    func didTapBuyButton(for product: CollectionItem) {
        print("Comprando assinatura do produto: \(product.name)")
    }
}


