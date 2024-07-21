//
//  NewsViewModelTest.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class NewsViewModelTests: XCTestCase {
    var newsViewModel: NewsViewModel!
    var mockNews: News!
    var mockService: MockService!

    override func setUp() {
        super.setUp()

        mockService = MockService()
        mockNews = getMockData(from: "NewsResponseMockDataTests")
        mockService.result = mockNews
        newsViewModel = NewsViewModel(service: mockService)
    }

    override func tearDown() {
        newsViewModel = nil
        mockNews = nil
        mockService = nil

        super.tearDown()
    }

    func testFetchNewsSucces() {
        let expectation = self.expectation(description: "Fetch news success")

        newsViewModel.fetchNews {
            XCTAssertEqual(self.newsViewModel.getCountOfNews(), 3)

            let expectedThumbnail = "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org"
            XCTAssertNotNil(self.newsViewModel.getThumbnailImage(for: expectedThumbnail))
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchNewsFailed() {
        let expectation = self.expectation(description: "Fetch news failed")
        mockService.result = []

        newsViewModel.fetchNews(completion: {})

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.newsViewModel.getCountOfNews(), 0)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)

        mockService.result = mockNews
    }

    func testFilterNews() {
        let expectation = self.expectation(description: "Filter news success")

        newsViewModel.fetchNews {
            self.newsViewModel.filterNews(for: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
            XCTAssertEqual(self.newsViewModel.getCountOfNews(), 1)
            XCTAssertEqual(self.newsViewModel.getNewsElement(at: 0)?.title,
                           "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testGetImage() {
        let expectation = self.expectation(description: "Get image success")

        newsViewModel.fetchNews {
            self.newsViewModel.getImage(for: self.mockNews[0]) { image in
                XCTAssertNotNil(image)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1)
    }
}
