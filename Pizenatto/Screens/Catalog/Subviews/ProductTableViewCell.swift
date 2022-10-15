//
//  ProductTableViewCell.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: ProductViewModel) {
        titleLabel.text = viewModel.title
    }
    
    private func setupCell() {
        // TODO: -
        contentView.addSubview(titleLabel)
        titleLabel.frame = contentView.bounds
    }
}



