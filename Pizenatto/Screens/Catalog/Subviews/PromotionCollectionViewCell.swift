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
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: PromotionViewModel) {
        // TODO: -
        guard let url = URL(string: viewModel.imageUrl) else {
            // handle error
            return
        }
        do {
            let data = try Data(contentsOf: url)
            imageView.image = UIImage(data: data)
        } catch {
            // handle error
            print("404 image not found")
        }
    }
    
    private func setupCell() {
        // TODO: - переделать на констеитнты
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
        
        contentView.layer.cornerRadius = 12
    }
}
