//
//  MockService.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

@testable import JSONPlaceholderApp

class MockService: Service {
    var result: [Decodable] = []

    override func fetchData<T: Decodable>(for path: ServicePath,
                                          completion: @escaping (Result<T, ServiceError>) -> Void) {
        if !result.isEmpty, let result = result as? T {
            completion(.success(result))
        } else {
            completion(.failure(.nilData))
        }
    }
}
