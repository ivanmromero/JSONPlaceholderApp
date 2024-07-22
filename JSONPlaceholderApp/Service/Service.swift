//
//  Service.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 17/07/2024.
//

import Foundation
import UIKit

class Service {
    func fetchData<T: Decodable>(for path: ServicePath, completion: @escaping (Result<T, ServiceError>) -> Void ) {
        guard let url = getURL(for: path)
        else {
            completion(.failure(.invalidURL))
            return
        }

        fetchData(for: url, completion: completion)
    }

    func fetchData<T: Decodable>(for url: URL?, completion: @escaping (Result<T, ServiceError>) -> Void) {
        fetchData(for: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError(localizedDescription: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchData(for url: URL?, completion: @escaping (Result<Data, ServiceError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            let statusCode: Int? = (response as? HTTPURLResponse)?.statusCode

            if let error = error {
                completion(.failure(.requestFailed(statusCode: statusCode ?? 0,
                                                   localizedDescription: error.localizedDescription)))
                return
            }

            guard let data = data else {
                completion(.failure(.nilData))
                return
            }

            guard let statusCode = statusCode, (200...299).contains(statusCode) else {
                completion(.failure(.requestFailed(statusCode: statusCode ?? 0)))
                return
            }

            completion(.success(data))

        }.resume()
    }

    func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        fetchData(for: URL(string: url)) { (result: Result<Data, ServiceError>) in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
            case .failure(let error):
                error.handleError()
                completion(nil)
            }
        }
    }

    private func getURL(for servicePath: ServicePath) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.org"
        urlComponents.path = servicePath.path

        return urlComponents.url
    }
}
