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
    
    func fetchNews(completion: @escaping () -> ()) {
        service.fetchData(for: .allPosts) { [weak self] (result: Result<News, ServiceError>) in
            switch result {
            case .success(let news):
                self?.news = news
                self?.fecthThumbnailImages(completion: completion)
            case .failure(let error):
                error.handleError()
            }
        }
    }
    
    private func fecthThumbnailImages(completion: @escaping () -> ()) {
        let group = DispatchGroup()
        
        for newsItem in news {
            group.enter()
            service.fetchData(for: URL(string: newsItem.thumbnail)) { [weak self] (result: Result<Data, ServiceError>) in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.thumbnailImages[newsItem.thumbnail] = UIImage(data: data)
                case .failure(let error):
                    error.handleError()
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func getNewsElement(at index: Int) -> NewsElement? {
        guard index >= 0 && index < filteredNews.count else { return nil }
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
        
        filteredNews = text.isEmpty ? news : news.filter { $0.title.lowercased().contains(lowercasedText) || $0.content.lowercased().contains(lowercasedText) }
    }
}
