//
//  NewsModel.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 18/07/2024.
//

typealias News = [NewsElement]

struct NewsElement: Decodable {
    let title: String
    let content: String
    let image: String
    let thumbnail: String
    let category: String
    let publishedAt: String
}
