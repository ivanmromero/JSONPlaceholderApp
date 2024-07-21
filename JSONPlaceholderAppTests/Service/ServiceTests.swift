//
//  JSONPlaceholderAppTests.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 20/07/2024.
//

import XCTest
@testable import JSONPlaceholderApp

final class ServiceTests: XCTestCase {
    var service: Service!

    override func setUp() {
        super.setUp()

        service = Service()
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        service = nil

        super.tearDown()
    }

    func testFetchDataSuccess() {
        let expectedResponse = loadJSONData(filename: "NewsResponseMockDataTests")

        guard let expectedData = try? JSONEncoder().encode(expectedResponse)
        else {
            XCTFail("Error encoding data - testFetchDataSuccess")
            return
        }

        setupRequestHandler(with: 200, expectedData: expectedData)

        let expectation = self.expectation(description: "Fetching data succeeds")

        service.fetchData(for: .allPosts) { (result: Result<Data, ServiceError>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response, expectedResponse)
            case .failure(let error):
                XCTFail("Expected success but got \(error) instead")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchDataFailure() {
        setupRequestHandler(with: 404)

        let expectation = self.expectation(description: "Fetching data fails")

        service.fetchData(for: .allUsers) { (result: Result<String, ServiceError>) in
            switch result {
            case .success(let data):
                XCTFail("Expected failure but got \(data) instead")
            case .failure(let error):
                switch error {
                case .requestFailed(let statusCode, _):
                    XCTAssertEqual(statusCode, 404)
                default:
                    XCTFail("Expected requestFailed error but got \(error) instead")
                }
            }
            expectation.fulfill()
        }

       waitForExpectations(timeout: 1)
    }

    func testFetchImageSuccess() {
        let expectedImage = UIImage(systemName: "person.crop.circle")!
        let expectedData = expectedImage.pngData()!

        setupRequestHandler(with: 200, expectedData: expectedData)

        let expectation = self.expectation(description: "Fetching image succeeds")

        service.fetchImage(url: "https://example.com/image.png") { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchImageFailure() {
        let expectation = self.expectation(description: "Fetching image fails")

        service.fetchImage(url: "https://example.com/image.png") { image in
            XCTAssertNil(image)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    private func setupRequestHandler(with statusCode: Int, expectedData: Data = Data()) {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: statusCode,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, expectedData)
        }
    }
}
