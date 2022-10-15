//
//  NetworkManager.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import Foundation

protocol Networkable {
    func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

enum NetworkError: Error {
    case urlError
    case urlResponseError
    case dataError
    case authError(statusCode: Int)
    case unknownError
}

final class NetworkService {
    
    private let decoderService: Decoderable
    
    init(decoderService: Decoderable) {
        self.decoderService = decoderService
    }
}

extension NetworkService: Networkable {
    
    func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        func completionHandler(result: Result<T, Error>) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: urlString) else {
                completionHandler(result: .failure(NetworkError.urlError))
                return
            }
            URLSession.shared.dataTask(with: url) { data, respose, error in
                if let error = error {
                    completionHandler(result: .failure(error))
                    return
                }
                
                guard let urlResponse = respose as? HTTPURLResponse else {
                    completionHandler(result: .failure(NetworkError.urlResponseError))
                    return
                }
                
                switch urlResponse.statusCode {
                case 200...299:
                    guard let data = data else {
                        completionHandler(result: .failure(NetworkError.dataError))
                        return
                    }
                    // TODO: - self
                    self.decoderService.decode(data, completion: completion)
                default:
                    completionHandler(result: .failure(NetworkError.authError(statusCode: urlResponse.statusCode)))
                    return
                }
            }.resume()
        }
    }
}
