//
//  ProductTableViewCell.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit

protocol ProductTableViewCellDelegate: AnyObject {
    func productTableViewCellDidTapPrice(_ cell: ProductTableViewCell)
}

final class ProductTableViewCell: UITableViewCell {
    
    weak var delegate: ProductTableViewCellDelegate?
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
        descriptionLabel.text = viewModel.desciption
        priceButton.setTitle(viewModel.price, for: .normal)
        productImageView.loadImage(urlString: viewModel.imageUrl)
    }
    
    private func setupCell() {
        addSubviews()
        setupContraints()
    }
    
    private func addSubviews() {
        contentView.myAddSubViews(from: [
            productImageView,
            titleLabel,
            descriptionLabel,
            priceButton,
            separatorView
        ])
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.heightAnchor.constraint(equalToConstant: 132),
            productImageView.widthAnchor.constraint(equalToConstant: 132),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -24),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            priceButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            priceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            priceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            priceButton.heightAnchor.constraint(equalToConstant: 32),
            priceButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 87),
            
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @objc
    private func didTapButton() {
        delegate?.productTableViewCellDidTapPrice(self)
    }
}



