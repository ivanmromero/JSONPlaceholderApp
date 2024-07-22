//
//  NewsViewModel.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 18/07/2024.
//

import UIKit

final class NewsViewModel {
    private let service: Service
    private var news: News {
        didSet {
            filteredNews = news
        }
    }
    private var thumbnailImages: [String: UIImage]
    private var filteredNews: News

    init(service: Service) {
        self.service = service
        self.news = []
        self.thumbnailImages = [:]
        self.filteredNews = []
    }

    func fetchNews(completion: @escaping () -> Void) {
        service.fetchData(for: .allPosts) { [weak self] (result: Result<News, ServiceError>) in
            switch result {
            case .success(let news):
                self?.news = news
                self?.fetchThumbnailImages(completion: completion)
            case .failure(let error):
                error.handleError()
            }
        }
    }

    private func fetchThumbnailImages(completion: @escaping () -> Void) {
        let group = DispatchGroup()

        for newsElement in news {
            group.enter()
            service.fetchImage(url: newsElement.thumbnail) { [weak self] image in
                if let image = image {
                    self?.thumbnailImages[newsElement.thumbnail] = image
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion()
        }
    }

    func getImage(for newsElement: NewsElement, completion: @escaping (UIImage?) -> Void) {
        service.fetchImage(url: newsElement.image, completion: completion)
    }

    func getNewsElement(at index: Int) -> NewsElement? {
        guard index >= 0 && index < getCountOfNews() else { return nil }

        return filteredNews[index]
    }

    func getCountOfNews() -> Int {
        filteredNews.count
    }

    func getThumbnailImage(for thumbnailUrl: String) -> UIImage? {
        thumbnailImages[thumbnailUrl]
    }

    func filterNews(for text: String) {
        let lowercasedText = text.lowercased()

        filteredNews = text.isEmpty ? news : news.filter {
            $0.title.lowercased().contains(lowercasedText) || $0.content.lowercased().contains(lowercasedText)
        }
    }
}
