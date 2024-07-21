//
//  UsersViewModelTest.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class UsersViewModelTests: XCTestCase {
    var usersViewModel: UsersViewModel!
    var mockUsers: Users!
    var mockService: MockService!

    override func setUp() {
        super.setUp()

        mockService = MockService()
        mockUsers = getMockData(from: "UsersResponseMockDataTests")
        mockService.result = mockUsers
        usersViewModel = UsersViewModel(service: mockService)
    }

    override func tearDown() {
        usersViewModel = nil
        mockUsers = nil
        mockService = nil

        super.tearDown()
    }

    func testFetchUsersSucces() {
        let expectation = self.expectation(description: "Fetch Users success")

        usersViewModel.fetchUsers {
            XCTAssertEqual(self.usersViewModel.getCountOfUsers(), 3)

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchUsersFailed() {
        let expectation = self.expectation(description: "Fetch Users failed")
        mockService.result = []

        usersViewModel.fetchUsers(completion: {})

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.usersViewModel.getCountOfUsers(), 0)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)

        mockService.result = mockUsers
    }

    func testGetUser() {
        let expectation = self.expectation(description: "Get User success")

        usersViewModel.fetchUsers {
            XCTAssertEqual(self.usersViewModel.getCountOfUsers(), 3)
            XCTAssertEqual(self.usersViewModel.getUser(at: 0)?.firstname, self.mockUsers[0].firstname)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }
}
