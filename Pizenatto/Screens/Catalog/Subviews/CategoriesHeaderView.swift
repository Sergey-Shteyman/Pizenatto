//
//  CategoriesHeaderView.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit

protocol CategoriesHeaderViewDelegate: AnyObject {
    func categoryHeaderViewDidTapCell(at indexPath: IndexPath)
}

final class CategoriesHeaderView: UITableViewHeaderFooterView {
    
    weak var delegate: CategoriesHeaderViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 80
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.myRegister(CategoryCollectionViewCell.self)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var categories: [CategoryCellViewModel] = [
            CategoryCellViewModel(title: "Пицца", isSelected: true),
            CategoryCellViewModel(title: "Комбо", isSelected: false),
            CategoryCellViewModel(title: "123", isSelected: false),
            CategoryCellViewModel(title: "4321", isSelected: false)
        ]
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: [CategoryCellViewModel]) {
        categories = viewModel
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate Impl
extension CategoriesHeaderView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - UICollectionViewDataSource Impl
extension CategoriesHeaderView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.myDequeueReusableCell(type: CategoryCollectionViewCell.self, indePath: indexPath)
        let viewModel = categories[indexPath.item]
        cell.configureCell(with: viewModel)
//        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Impl
extension CategoriesHeaderView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 32)
    }
}

private extension CategoriesHeaderView {
    private func setupCell() {
        contentView.backgroundColor = .purple
        
        contentView.myAddSubView(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}

