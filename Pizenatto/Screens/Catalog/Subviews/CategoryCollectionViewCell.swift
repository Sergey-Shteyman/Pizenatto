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
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.layer.cornerRadius = 16
        button.tintColor = .systemPink
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
            button.backgroundColor = UIColor(red: 1.0, green: 0.2, blue: 0.4, alpha: 0.2)
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
