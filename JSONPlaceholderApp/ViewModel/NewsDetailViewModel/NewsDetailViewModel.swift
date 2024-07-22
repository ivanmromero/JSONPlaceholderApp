//
//  NewsDetailViewModel.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 19/07/2024.
//

import UIKit

final class NewsDetailViewModel {
    private let newsElement: NewsElement
    let coverImage: UIImage?
    var title: String { newsElement.title }
    var content: String { newsElement.content }
    var category: String { newsElement.category }
    var publishedAt: String { newsElement.publishedAt }

    init(newsElement: NewsElement, coverImage: UIImage?) {
        self.newsElement = newsElement
        self.coverImage = coverImage
    }
}
