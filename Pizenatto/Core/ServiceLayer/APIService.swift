//
//  APIService.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//


import Foundation

protocol APIServicable {
//    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}

final class APIService {
    
    private let networkService: Networkable
    
    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

extension APIService: APIServicable {
    
//    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
//        let urlString = "https://jsonplaceholder.typicode.com/posts"
//        networkService.request(urlString: urlString, completion: completion)
//    }
}

//struct Post: Decodable {
//    let userId: Int?
//    let id: Int?
//    let title: String?
//    let body: String?
//}
