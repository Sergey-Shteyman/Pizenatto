//
//  ProductModel.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 15.10.2022.
//

struct ProductModel: Decodable {
    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Int
    let currency: String
    let imageUrl: String
}

