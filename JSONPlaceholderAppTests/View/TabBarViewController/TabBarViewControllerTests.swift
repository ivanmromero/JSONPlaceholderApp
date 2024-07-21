//
//  TabBarViewControllerTest.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class TabBarViewControllerTests: XCTestCase {
    var tabBarViewController: TabBarViewController!

    override func setUp() {
        super.setUp()

        tabBarViewController = TabBarViewController()
        tabBarViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        tabBarViewController = nil

        super.tearDown()
    }

    func testSetup() {
        let viewControllers = tabBarViewController.viewControllers
        XCTAssertNotNil(viewControllers)
        XCTAssertEqual(viewControllers?.count, 2)

        let firstNavController = viewControllers?.first as? UINavigationController
        let secondNavController = viewControllers?.last as? UINavigationController

        XCTAssertNotNil(firstNavController)
        XCTAssertNotNil(secondNavController)

        XCTAssertTrue(firstNavController?.topViewController is NewsViewController)
        XCTAssertTrue(secondNavController?.topViewController is UsersViewController)

        XCTAssertEqual(firstNavController?.tabBarItem.title, "News")
        XCTAssertEqual(secondNavController?.tabBarItem.title, "Users")
        XCTAssertEqual(firstNavController?.tabBarItem.image?.pngData(), UIImage(systemName: "newspaper")?.pngData())
        XCTAssertEqual(secondNavController?.tabBarItem.image?.pngData(),
                       UIImage(systemName: "person.crop.circle.fill")?.pngData())
    }

    func testAppearance() {
        let appearance = tabBarViewController.tabBar.standardAppearance
        XCTAssertNotNil(appearance)
        XCTAssertNotNil(tabBarViewController.tabBar.scrollEdgeAppearance)
    }
}
