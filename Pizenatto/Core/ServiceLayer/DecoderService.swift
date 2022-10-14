//
//  JSONDecoderManager.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import Foundation


// MARK: Decoderable
protocol Decoderable {
    func decode<T: Decodable>(_ data: Data, completion: @escaping (Result<T, Error>) -> Void)
}

// MARK: - DecoderService
final class DecoderService{
    private let decoder = JSONDecoder()
}

// MARK: - DecoderService Impl
extension DecoderService: Decoderable {
    
    func decode<T: Decodable>(_ data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let result = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }
            
            catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
