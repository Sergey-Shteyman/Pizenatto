//
//  APIService.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//


protocol APIServicable {
    func fetchPromotions(completion: @escaping (Result<[PromotionModel], Error>) -> Void)
    func fetchCategories(completion: @escaping (Result<[CategoryResponseModel], Error>) -> Void)
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
        let urlString = "https://gist.githubusercontent.com/Sergey-Shteyman/2a7aa78ababc886c7a2c7f0a0da6b3ee/raw/7122b737d463c75d7f90689c477dc06e5011f1d4/promotion.json"
        networkService.request(urlString: urlString, completion: completion)
    }
    
    func fetchCategories(completion: @escaping (Result<[CategoryResponseModel], Error>) -> Void) {
        let urlString = "https://gist.githubusercontent.com/Sergey-Shteyman/2a7aa78ababc886c7a2c7f0a0da6b3ee/raw/7122b737d463c75d7f90689c477dc06e5011f1d4/Categories.json"
        networkService.request(urlString: urlString, completion: completion)
    }
    
    func fetchProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let urlString = "https://gist.githubusercontent.com/Sergey-Shteyman/2a7aa78ababc886c7a2c7f0a0da6b3ee/raw/7122b737d463c75d7f90689c477dc06e5011f1d4/Products.json"
        networkService.request(urlString: urlString, completion: completion)
    }
}

