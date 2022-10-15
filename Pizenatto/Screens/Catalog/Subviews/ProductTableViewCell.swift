//
//  ProductTableViewCell.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit

struct ProductCellViewModel {
    let title: String
    let categoryId: Int

}

final class ProductTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: ProductCellViewModel) {
        
    }
}

// MARK: - Private methods
private extension ProductTableViewCell {
    
    func setupCell() {
        
    }
}

