//
//  UserMapViewModel.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 20/07/2024.
//

import Foundation

final class UserMapViewModel {
    private let userAddress: Address
    var street: String { userAddress.street }
    var zipCode: String { userAddress.zipcode }

    init(userAddress: Address) {
        self.userAddress = userAddress
    }

    func createGoogleMapsURL() -> URL? {
        var components = URLComponents()

        components.scheme = "https"
        components.host = "www.google.com"
        components.path = "/maps"

        let latitude = userAddress.geo.lat
        let longitude = userAddress.geo.lng

        components.queryItems = [
            URLQueryItem(name: "q", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "z", value: "15"),
            URLQueryItem(name: "markers", value: "color:red|\(latitude),\(longitude)")
        ]

        return components.url
    }
}
