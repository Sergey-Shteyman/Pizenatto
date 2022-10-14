//
//  NetworkManager.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import Foundation

import Foundation

// MARK: - Networkable
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

// MARK: - NetworkService
final class NetworkService {
    
    private let decoderService: Decoderable
    
    init(decoderService: Decoderable) {
        self.decoderService = decoderService
    }
}

// MARK: - Networkable impl
extension NetworkService: Networkable {
    
    func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        func comletionHandler(result: Result <T, Error>) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: urlString) else {
                comletionHandler(result: .failure(NetworkError.urlError))
                return
            }
            let session = URLSession.shared.dataTask(with: url) { data, respose, error in
                if let error = error {
                    comletionHandler(result: .failure(error))
                    return
                }
                
                guard let urlResponse = respose as? HTTPURLResponse else {
                    comletionHandler(result: .failure(NetworkError.urlResponseError))
                    return
                }
                
                switch urlResponse.statusCode {
                case 200...299:
                    guard let data = data else {
                        comletionHandler(result: .failure(NetworkError.dataError))
                        return
                    }

                    self.decoderService.decode(data, completion: completion)
                default:
                    comletionHandler(result: .failure(NetworkError.authError(statusCode: urlResponse.statusCode)))
                    return
                }
            }.resume()
        }
    }
}
