//
//  UserModel.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 18/07/2024.
//

typealias Users = [User]

struct User: Decodable {
    let firstname: String
    let lastname: String
    let email: String
    let birthDate: String
    let address: Address
    let website: String
}

struct Address: Decodable {
    let street: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Decodable {
    let lat, lng: String
}
