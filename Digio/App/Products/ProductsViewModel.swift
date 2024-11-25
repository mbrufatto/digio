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
    func createCollectionView(for type: CollectionType) -> UICollectionView
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
    
    func createCollectionView(for type: CollectionType) -> UICollectionView {
        let configuration: CollectionViewConfiguration
        switch type {
        case .spotlight:
            configuration = CollectionViewConfiguration(itemSize: CGSize(width: 350, height: 180), spacing: 20, scrollDirection: .horizontal)
        case .cash:
            configuration = CollectionViewConfiguration(itemSize: CGSize(width: 350, height: 100), spacing: 0, scrollDirection: .horizontal)
        case .products:
            configuration = CollectionViewConfiguration(itemSize: CGSize(width: 110, height: 110), spacing: 20, scrollDirection: .horizontal)
        }
        let factory = CollectionFactoryMap.factory(for: type)
        return factory.createCollectionView(with: configuration)
    }
}
