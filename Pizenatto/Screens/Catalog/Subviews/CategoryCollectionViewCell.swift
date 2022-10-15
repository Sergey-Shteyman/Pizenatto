//
//  CategorieCollectionViewCell.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit

protocol CategoryCollectionViewCellDelegate: AnyObject {
    func categoryCollectionViewCellDidTapButton(_ cell: CategoryCollectionViewCell)
}

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CategoryCollectionViewCellDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: CategoryViewModel) {
        button.setTitle(viewModel.title, for: .normal)
        if viewModel.isSelected {
            button.backgroundColor = .red
        } else {
            button.backgroundColor = .clear
        }
    }
    
    private func setupCell() {
        // TODO: - переделать на констеитнты
        contentView.addSubview(button)
        button.frame = contentView.bounds
    }
    
    @objc
    private func didTapButton() {
        delegate?.categoryCollectionViewCellDidTapButton(self)
    }
}

