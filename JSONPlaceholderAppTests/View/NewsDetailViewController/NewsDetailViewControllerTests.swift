//
//  NewsDetailViewController.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class NewsDetailViewControllerTests: XCTestCase {
    var newsDetailViewController: NewsDetailViewController!
    var newsDetailViewModel: NewsDetailViewModel!

    override func setUp() {
        super.setUp()

        let mockNewsElement = NewsElement(title: "title",
                                      content: "content",
                                      image: "image",
                                      thumbnail: "thumbnail",
                                      category: "category",
                                      publishedAt: "2024-01-01")
        let mockCoverImage = UIImage(systemName: "newspaper")
        newsDetailViewModel = NewsDetailViewModel(newsElement: mockNewsElement, coverImage: mockCoverImage)
        newsDetailViewController = NewsDetailViewController(viewModel: newsDetailViewModel)

        newsDetailViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        newsDetailViewController = nil
        newsDetailViewModel = nil

        super.tearDown()
    }

    func testDataDisplayed() {
        XCTAssertEqual(newsDetailViewController.titleLabel.text, newsDetailViewModel.title)
        XCTAssertEqual(newsDetailViewController.contentLabel.text, newsDetailViewModel.content)
        XCTAssertEqual(newsDetailViewController.coverImage.image, newsDetailViewModel.coverImage)
        XCTAssertEqual(newsDetailViewController.categoryLabel.text, newsDetailViewModel.category)
        XCTAssertEqual(newsDetailViewController.publishedAtLabel.text, newsDetailViewModel.publishedAt)
    }
}
