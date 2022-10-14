//
//  CategorieCollectionViewCell.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit


// MARK: - CategorieCollectionViewCell
final class CategoryCollectionViewCell: UICollectionViewCell {

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

    @objc
    private func didTapButton() {
        print(#function)
    }

    func configureCell(with viewModel: CategoryCellViewModel) {
        button.setTitle(viewModel.title, for: .normal)
        if viewModel.isSelected {
            button.backgroundColor = .red
        } else {
            button.backgroundColor = .clear
        }
    }
}

// MARK: - private methods
private extension CategoryCollectionViewCell {

    func setupCell() {
        // TODO: - Refactore to Constraints
        contentView.addSubview(button)
        button.frame = contentView.bounds
    }
}

// MARK: - CategoryCellViewModel
struct CategoryCellViewModel {
    let title: String
    let isSelected: Bool
}
