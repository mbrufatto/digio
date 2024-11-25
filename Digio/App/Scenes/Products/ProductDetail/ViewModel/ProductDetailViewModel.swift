//
//  ProductDetailViewModel.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 25/11/24.
//

class ProductDetailViewModel {
    
    private var product: CollectionItem?
    
    init(product: CollectionItem) {
        self.product = product
    }
    
    func getProduct() -> CollectionItem? {
        product
    }
}
