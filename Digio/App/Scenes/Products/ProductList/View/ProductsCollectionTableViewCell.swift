//
//  ProductsCollectionTableViewCell.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 23/11/24.
//
import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CollectionTableViewCell"
    
    private var collectionView: UICollectionView!
    private var colletionType: CollectionType!

    var selectProduct: ((CollectionItem) -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var items: [CollectionItem] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with collectionView: UICollectionView, items: [CollectionItem]?, collectionType: CollectionType, title: String = "") {
        
        self.collectionView = collectionView
        setupCollectionView()
        setupConstraints()
        self.colletionType = collectionType
        
        configureCollectionLeadingAnchor()
        configureTitleLabel(text: title)
    
        DispatchQueue.main.async {
            self.items = items ?? []
            collectionView.reloadData()
        }
    }
    
    private func configureTitleLabel(text: String) {
        
        titleLabel.textColor = UIColor(named: "PrimaryColor")
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        switch colletionType {
        case .spotlight:
            titleLabel.text = text
        case .cash:
            let range = (text as NSString).range(of: "Cash")
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: range)
            titleLabel.attributedText = attributedString
        case .products:
            titleLabel.text = text
        case .none:
            titleLabel.text = ""
        }
        
    }
    
    private func configureCollectionLeadingAnchor() {
        switch colletionType {
        case .cash, .spotlight:
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        case .products:
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        case .none:
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        }
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectProduct?(items[indexPath.row])
    }
}

extension CollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.configure(with: items[indexPath.row], collectionType: self.colletionType)
        return cell
    }
}
