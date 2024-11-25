//
//  Untitled.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 24/11/24.
//

import Foundation
import UIKit

protocol CollectionViewFactoryProtocol: AnyObject {
    func createCollectionView(with configuration: CollectionViewConfiguration) -> UICollectionView
}

enum CollectionType {
    case spotlight
    case cash
    case products
}

struct CollectionViewConfiguration {
    let itemSize: CGSize
    let spacing: CGFloat
    let scrollDirection: UICollectionView.ScrollDirection
}


struct CollectionFactoryMap {
    static func factory(for type: CollectionType) -> CollectionViewFactoryProtocol {
        switch type {
        case .spotlight: return SpotlightCollectionViewFactory()
        case .cash: return CashCollectionViewFactory()
        case .products: return ProductsCollectionViewFactory()
        }
    }
}

class SpotlightCollectionViewFactory: CollectionViewFactoryProtocol {
    func createCollectionView(with configuration: CollectionViewConfiguration) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Coleção horizontal
        layout.itemSize = configuration.itemSize
        layout.minimumLineSpacing = configuration.spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // Ajustar espaçamento das células
        
        // Criar a collectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear // Ou qualquer outra cor de fundo desejada
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }
}


class CashCollectionViewFactory: CollectionViewFactoryProtocol {
    func createCollectionView(with configuration: CollectionViewConfiguration) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Coleção horizontal
        layout.itemSize = configuration.itemSize
        layout.minimumLineSpacing = configuration.spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // Ajustar espaçamento das células
        
        // Criar a collectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear // Ou qualquer outra cor de fundo desejada
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }
}

class ProductsCollectionViewFactory: CollectionViewFactoryProtocol {
    func createCollectionView(with configuration: CollectionViewConfiguration) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Coleção horizontal
        layout.itemSize = configuration.itemSize
        layout.minimumLineSpacing = configuration.spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // Ajustar espaçamento das células
        
        // Criar a collectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear // Ou qualquer outra cor de fundo desejada
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }
}
