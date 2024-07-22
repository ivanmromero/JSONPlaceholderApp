//
//  UserMapViewModelTest.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class UserMapViewModelTests: XCTestCase {
    var userMapViewModel: UserMapViewModel!
    var mockAddress: Address!

    override func setUp() {
        super.setUp()

        let mockGeo = Geo(lat: "37.7749", lng: "-122.4194")
        mockAddress = Address(street: "123 Market St", zipcode: "94105", geo: mockGeo)
        userMapViewModel = UserMapViewModel(userAddress: mockAddress)
    }

    override func tearDown() {
        userMapViewModel = nil
        mockAddress = nil

        super.tearDown()
    }

    func testProperties() {
        XCTAssertEqual(userMapViewModel.street, mockAddress.street)
        XCTAssertEqual(userMapViewModel.zipCode, mockAddress.zipcode)
    }

    func testCreateGoogleMapsURL() {
        let host = "https://www.google.com"
        let path = "/maps"
        let queryItems = "?q=37.7749,-122.4194&ll=37.7749,-122.4194&z=15&markers=color:red%7C37.7749,-122.4194"
        let expectedURL = URL(string: host + path + queryItems)

        XCTAssertEqual(userMapViewModel.createGoogleMapsURL(), expectedURL)
    }
}
