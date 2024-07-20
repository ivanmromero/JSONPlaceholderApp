//
//  ServicePath.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 18/07/2024.
//

enum ServicePath: String {
    case allPosts = "posts"
    case allUsers = "users"

    var path: String { "/\(self.rawValue)"}
}
