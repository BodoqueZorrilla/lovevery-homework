//
//  UsersTests.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 11/04/24.
//

import XCTest
@testable import LoveveryHomework

final class UsersTests: XCTestCase {
    private var sut: MockUsersViewModelMock!
    private var mockApiCaller: MockApiFetcher!

    override func setUpWithError() throws {
        mockApiCaller = MockApiFetcher()
        sut =  MockUsersViewModelMock(apiCaller: mockApiCaller)
        
    }

    override func tearDownWithError() throws {
        mockApiCaller = nil
        sut = nil
    }

    func testUsersViewModel_getUsers_SuccessfulFetch() async throws {

        mockApiCaller.fetchCompletion = { result in
            guard case let .success(response) = result else { return }
        }

        try await sut.getUsers()

        XCTAssertTrue(sut.getUsersCalled)
        XCTAssertTrue(mockApiCaller.fetchCalled)
        XCTAssertEqual(mockApiCaller.fetchUrl, PathsUrl.messages.pathId)
    }
}
