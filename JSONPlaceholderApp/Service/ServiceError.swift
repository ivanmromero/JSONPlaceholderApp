//
//  ServiceError.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 18/07/2024.
//

enum ServiceError: Error {
    case invalidURL
    case nilData
    case requestFailed(statusCode: Int, localizedDescription: String? = nil)
    case decodingError(localizedDescription: String? = nil)

    func handleError() {
        switch self {
        case .invalidURL:
            print("Error: Invalid URL.")
        case .nilData:
            print("Error: No data received in response.")
        case .requestFailed(statusCode: let statusCode, localizedDescription: let localizedDescription):
            print("Error: Request failed with status code \(statusCode).")
            printErrorDescription(with: localizedDescription)
        case .decodingError(localizedDescription: let localizedDescription):
            print("Error: There was an error decoding the received data.")
            printErrorDescription(with: localizedDescription)
        }
    }

    private func printErrorDescription(with localizedDescription: String?) {
        if let localizedDescription = localizedDescription {
            print("Error Description: \(localizedDescription).")
        }
    }
}
