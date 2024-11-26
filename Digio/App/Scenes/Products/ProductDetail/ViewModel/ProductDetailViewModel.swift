//
//  ProductDetailViewModel.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 25/11/24.
//

class ProductDetailViewModel {
    
    private var product: ProductItem?
    
    init(product: ProductItem) {
        self.product = product
    }
    
    func getProduct() -> ProductItem? {
        product
    }
}
