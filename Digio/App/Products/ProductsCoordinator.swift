//
//  ProductsCoordinator.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 23/11/24.
//
import UIKit

protocol ProductsCoordinatorProtocol: AnyObject {
    func start()
    func showProductDetails(for product: Product)
}

class ProductsCoordinator: ProductsCoordinatorProtocol {
    private let navigationController: UINavigationController
    private let networkService: NetworkServiceProtocol
    
    init(navigationController: UINavigationController, networkService: NetworkServiceProtocol) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    func start() {
        let viewModel = ProductsViewModel(networkService: networkService)
        let productsViewController = ProductsViewController(viewModel: viewModel, coordinator: self)
        navigationController.setViewControllers([productsViewController], animated: false)
    }
    
    func showProductDetails(for product: Product) {
    }
}


