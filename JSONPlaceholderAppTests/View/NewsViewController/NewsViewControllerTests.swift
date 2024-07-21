//
//  NewsViewControllerTest.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class NewsViewControllerTests: XCTestCase {
    var newsViewController: NewsViewController!
    var newsViewModel: NewsViewModel!
    var mockNavigationController: MockNavigationController!

    override func setUp() {
        super.setUp()

        let service: MockService = MockService()
        let mockNews: News = getMockData(from: "NewsResponseMockDataTests")
        service.result = mockNews
        newsViewModel = NewsViewModel(service: service)
        newsViewController = NewsViewController(viewModel: newsViewModel)
        mockNavigationController = MockNavigationController(rootViewController: newsViewController)

        newsViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        newsViewController = nil
        newsViewModel = nil
        mockNavigationController = nil

        super.tearDown()
    }

    func testSetup() {
        XCTAssertEqual(newsViewController.title, "News")
        XCTAssertNotNil(newsViewController.tableView.dataSource)
        XCTAssertNotNil(newsViewController.tableView.delegate)
        XCTAssertNotNil(newsViewController.searchBar.delegate)
        XCTAssertEqual(newsViewController.searchBar.placeholder, "Search news")
    }

    func testDataSourceOnTableView() {
        XCTAssertEqual(self.newsViewController.tableView.numberOfRows(inSection: 0), 3)

        let indexPath = IndexPath(row: 0, section: 0)

        guard let cell = self.newsViewController.tableView.cellForRow(at: indexPath) as? NewsTableViewCell
        else {
            XCTFail("Cell is nil")
            return
        }

        let newsToEvaluate = self.newsViewModel.getNewsElement(at: 0)

        XCTAssertEqual(cell.titleLabel.text, newsToEvaluate?.title)
        XCTAssertEqual(cell.littleContentLabel.text, newsToEvaluate?.content)
        XCTAssertNotNil(cell.thumbnailImage)
        XCTAssertEqual(cell.accessoryType, .disclosureIndicator)
    }

    func testTableViewDidSelectRow() {
        newsViewController.tableView(newsViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        let expectation = self.expectation(description: "Wait for getImage closure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)

        XCTAssertTrue(mockNavigationController.didPushViewController)
        XCTAssert(mockNavigationController.viewControllerToPush is NewsDetailViewController)
    }

    func testSearchBarTextDidChange() {
        newsViewController.searchBar(newsViewController.searchBar,
                                     textDidChange: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")

        XCTAssertEqual(newsViewController.tableView.numberOfRows(inSection: 0), newsViewModel.getCountOfNews())
    }
}
