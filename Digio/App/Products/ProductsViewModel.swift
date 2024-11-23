//
//  ProductsViewModel.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//
import Foundation
import UIKit

protocol ProductsViewModelProtocol: AnyObject {
    var products: Products? { get }
    var onProductsUpdated: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    func fetchProducts()
}

class ProductsViewModel: ProductsViewModelProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    var products: Products? = nil {
        didSet {
            onProductsUpdated?()
        }
    }
    
    var onProductsUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchProducts() {
        let endpoint = ProductsAPIEndpoint.products
        
        networkService.request(endpoint) { [weak self] (result: Result<Products, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                case .failure(let error):
                    print("Erro ao buscar produtos: \(error.localizedDescription)")
                    self?.onError?(error)
                }
            }
        }
    }
}
