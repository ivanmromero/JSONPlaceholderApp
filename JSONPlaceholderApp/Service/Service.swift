//
//  Service.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 17/07/2024.
//

import Foundation

class Service {
    func fetchData<T: Decodable>(for path: ServicePath ,completion: @escaping (Result<T, ServiceError>) -> ()) {
        guard let url = getURL(for: path)
        else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let statusCode: Int? = (response as? HTTPURLResponse)?.statusCode
            
            if let error = error {
                completion(.failure(.requestFailed(statusCode: statusCode ?? 0, localizedDescription: error.localizedDescription)))
            }
            
            guard let data = data
            else {
                completion(.failure(.nilData))
                return
            }
            
            guard let statusCode = statusCode,
                  (200...299).contains(statusCode)
            else {
                completion(.failure(.requestFailed(statusCode: statusCode ?? 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                return
            }
            catch {
                completion(.failure(.decodingError(localizedDescription: error.localizedDescription)))
                return
            }
        }.resume()
    }
    
    private func getURL(for servicePath: ServicePath) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.org"
        urlComponents.path = servicePath.path
        
        return urlComponents.url
    }
}
