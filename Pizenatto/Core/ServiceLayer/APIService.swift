//
//  APIService.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//


import Foundation


protocol APIServicable {
    func fetchPromotions(completion: @escaping (Result<[PromotionModel], Error>) -> Void)
    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
    func fetchProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void)
}

final class APIService {
    
    private let networkService: Networkable
    
    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

extension APIService: APIServicable {
    
    func fetchPromotions(completion: @escaping (Result<[PromotionModel], Error>) -> Void) {
        let urlString = "https://gist.githubusercontent.com/Sergey-Shteyman/2a7aa78ababc886c7a2c7f0a0da6b3ee/raw/0a9a4337806f7c4c007b8d8cf1d296a2730ce0d5/promotion.json"
        networkService.request(urlString: urlString, completion: completion)
    }
    
    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        let urlString = "https://gist.githubusercontent.com/Sergey-Shteyman/2a7aa78ababc886c7a2c7f0a0da6b3ee/raw/0a9a4337806f7c4c007b8d8cf1d296a2730ce0d5/Categories.json"
        networkService.request(urlString: urlString, completion: completion)
    }
    
    func fetchProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let urlString = "https://gist.githubusercontent.com/Sergey-Shteyman/2a7aa78ababc886c7a2c7f0a0da6b3ee/raw/52f4e9f5807525ee422ff490aa7500b270f45a9e/Products.json"
        networkService.request(urlString: urlString, completion: completion)
    }
}

