//
//  XCTestCase+Extensions.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest

extension XCTestCase {
    func loadJSONData(filename: String, fileType: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: filename, withExtension: fileType) else {
            fatalError("Missing file: \(filename).\(fileType)")
        }

        do {
            return try Data(contentsOf: url)
        } catch {
            fatalError("Failed to load file: \(filename).\(fileType) with error: \(error)")
        }
    }

    func getMockData<T: Decodable>(from filename: String) -> T {
        let data = loadJSONData(filename: filename)

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("Failed to decoded file: \(filename) with error: \(error)")
        }
    }
}
