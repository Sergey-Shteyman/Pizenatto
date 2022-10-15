//
//  PromotionCollectionViewCell.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 15.10.2022.
//

import UIKit


final class PromotionCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    override func layoutSubviews() {
        imageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: PromotionViewModel) {
        imageView.loadImage(urlString: viewModel.imageUrl)
    }
    
    private func setupCell() {
        // TODO: - переделать на констеитнты
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
        
        contentView.layer.cornerRadius = 12
//        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
