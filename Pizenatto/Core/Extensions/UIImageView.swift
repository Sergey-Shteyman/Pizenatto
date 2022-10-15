//
//  UIImageView.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 15.10.2022.
//

import UIKit

extension UIImageView {
    func loadImage(urlString: String) {
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: urlString) else {
                return
            }
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(data: data)
                }
            } catch {
                print("404 image not found")
            }
        }
    }
}
