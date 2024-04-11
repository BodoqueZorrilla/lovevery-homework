//
//  HomeTests.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 06/04/24.
//

import XCTest
@testable import LoveveryHomework

final class HomeTests: XCTestCase {
    private var sut: MockHomeViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MockHomeViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testShowAddNewMessageScreen_ShowsSheet() {
        sut.showAddNewMessageScreen(show: true)
        XCTAssertTrue(sut.isShowingMessage)
    }

    func testShowAddNewMessageScreen_HidesSheet() {
        sut.showAddNewMessageScreen(show: false)
        XCTAssertFalse(sut.isShowingMessage)
    }

    func testReloadUsersMessages_SuccessfulFetch() async throws {
        try await sut.reloadUsersMessages()
        XCTAssertTrue(sut.isReloadMessages)
    }
}
