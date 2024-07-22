//
//  UserMapViewControllerTest.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class UserMapViewControllerTests: XCTestCase {
    var userMapViewController: UserMapViewController!
    var userMapViewModel: UserMapViewModel!

    override func setUp() {
        super.setUp()

        let mockGeo = Geo(lat: "37.7749", lng: "-122.4194")
        let mockAddress = Address(street: "123 Market St", zipcode: "94105", geo: mockGeo)
        userMapViewModel = UserMapViewModel(userAddress: mockAddress)
        userMapViewController = UserMapViewController(viewModel: userMapViewModel)

        userMapViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        userMapViewController = nil
        userMapViewModel = nil

        super.tearDown()
    }

    func testWebViewLoadURL() {
        let host = "https://www.google.com"
        let path = "/maps"
        let queryItems = "?q=37.7749,-122.4194&ll=37.7749,-122.4194&z=15&markers=color:red%7C37.7749,-122.4194"
        let expectedURL = URL(string: host + path + queryItems)

        let webView = userMapViewController.webView
        let urlRequest = webView?.url

        XCTAssertEqual(urlRequest, expectedURL)
    }

    func testLabelsDisplayCorrectData() {
        XCTAssertEqual(userMapViewController.streetLabel.text, userMapViewModel.street)
        XCTAssertEqual(userMapViewController.zipCodeLabel.text, userMapViewModel.zipCode)
    }
}
