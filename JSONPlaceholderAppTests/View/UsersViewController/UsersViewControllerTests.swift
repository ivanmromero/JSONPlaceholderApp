//
//  UsersViewControllerTest.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class UsersViewControllerTests: XCTestCase {
    var usersViewController: UsersViewController!
    var usersViewModel: UsersViewModel!
    var mockNavigationController: MockNavigationController!

    override func setUp() {
        super.setUp()

        let mockService = MockService()
        let mockUsers: Users = getMockData(from: "UsersResponseMockDataTests")
        mockService.result = mockUsers
        usersViewModel = UsersViewModel(service: mockService)
        usersViewController = UsersViewController(viewModel: usersViewModel)
        mockNavigationController = MockNavigationController(rootViewController: usersViewController)

        usersViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        usersViewController = nil
        usersViewModel = nil
        mockNavigationController = nil

        super.tearDown()
    }

    func testSetup() {
        XCTAssertEqual(usersViewController.title, "Users")
        XCTAssertNotNil(usersViewController.tableView.dataSource)
        XCTAssertNotNil(usersViewController.tableView.delegate)
    }

    func testDataSourceOnTableView() {
        XCTAssertEqual(self.usersViewController.tableView.numberOfRows(inSection: 0), 3)

        let indexPath = IndexPath(row: 0, section: 0)

        guard let cell = self.usersViewController.tableView.cellForRow(at: indexPath) as? UserTableViewCell
        else {
            XCTFail("Cell is nil")
            return
        }

        let userToEvaluate = self.usersViewModel.getUser(at: 0)
        let dataToEvaluate = [userToEvaluate?.firstname,
                              userToEvaluate?.lastname,
                              userToEvaluate?.birthDate,
                              userToEvaluate?.email,
                              userToEvaluate?.website ]

        for (index, label) in cell.stackView.arrangedSubviews.compactMap({ $0 as? UILabel }).enumerated() {
            let text = index == 2 ? dataToEvaluate[index]?.convertDate() : dataToEvaluate[index]

            XCTAssertEqual(label.text, text)
        }

        XCTAssertEqual(cell.accessoryType, .disclosureIndicator)
    }

    func testTableViewDidSelectRow() {
        usersViewController.tableView(usersViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        XCTAssertTrue(mockNavigationController.didPushViewController)
        XCTAssert(mockNavigationController.viewControllerToPush is UserMapViewController)
    }
}
