//
//  UICollectionViewCell.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit

extension UICollectionViewCell {

    class var myReuseId: String {
        return String(describing: Self.self)
    }
}
