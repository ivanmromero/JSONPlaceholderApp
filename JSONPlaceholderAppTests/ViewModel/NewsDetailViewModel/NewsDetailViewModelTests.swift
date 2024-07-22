//
//  NewsDetailViewModel.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class NewsDetailViewModelTests: XCTestCase {
    var newsDetailViewModel: NewsDetailViewModel!
    var mockNewsElement: NewsElement!
    var mockCoverImage: UIImage!

    override func setUp() {
        super.setUp()

        mockNewsElement = NewsElement(title: "title",
                                      content: "content",
                                      image: "image",
                                      thumbnail: "thumbnail",
                                      category: "category",
                                      publishedAt: "2024-01-01")
        mockCoverImage = UIImage(systemName: "newspaper")
        newsDetailViewModel = NewsDetailViewModel(newsElement: mockNewsElement, coverImage: mockCoverImage)
    }

    override func tearDown() {
        newsDetailViewModel = nil
        mockNewsElement = nil
        mockCoverImage = nil

        super.tearDown()
    }

    func testProperties() {
        XCTAssertEqual(newsDetailViewModel.title, mockNewsElement.title)
        XCTAssertEqual(newsDetailViewModel.content, mockNewsElement.content)
        XCTAssertEqual(newsDetailViewModel.category, mockNewsElement.category)
        XCTAssertEqual(newsDetailViewModel.publishedAt, mockNewsElement.publishedAt)
        XCTAssertEqual(newsDetailViewModel.coverImage, mockCoverImage)
    }
}
