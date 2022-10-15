//
//  PromotionsTableViewCell.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 15.10.2022.
//

import UIKit


final class PromotionsTableViewCell: UITableViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 80
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.myRegister(PromotionCollectionViewCell.self)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var promotions: [PromotionViewModel] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: PromotionsViewModel) {
        promotions = viewModel.promotions
        collectionView.reloadData()
    }
    
    private func setupCell() {
        // TODO: -
        contentView.addSubview(collectionView)
        collectionView.frame = contentView.bounds
    }
}

// MARK: - UICollectionViewDelegate Impl
extension PromotionsTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - UICollectionViewDataSource Impl
extension PromotionsTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        promotions.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.myDequeueReusableCell(type: PromotionCollectionViewCell.self, indePath: indexPath)
        let viewModel = promotions[indexPath.item]
        cell.configureCell(with: viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Impl
extension PromotionsTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 112)
    }
}
