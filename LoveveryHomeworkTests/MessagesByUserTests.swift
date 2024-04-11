//
//  MessagesByUserTests.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 11/04/24.
//

import XCTest
@testable import LoveveryHomework

final class MessagesByUserTests: XCTestCase {
    private var sut: MessagesByUserMocks!
    private var mockApiCaller: MockApiFetcherMessages!
    private var exactViewModel: MessagesByUserViewModel!
    
    override func setUpWithError() throws {
        mockApiCaller = MockApiFetcherMessages()
        sut =  MessagesByUserMocks(apiCaller: mockApiCaller)
        exactViewModel = MessagesByUserViewModel(user: "bodoque", apiFetcher: mockApiCaller)
    }
    
    override func tearDownWithError() throws {
        mockApiCaller = nil
        sut = nil
        exactViewModel = nil
    }
    
    func testMessagesByUser_getMessages_Mock_SuccessfulFetch() async throws {
        
        mockApiCaller.fetchCompletion = { result in
            guard case let .success(_) = result else { return }
        }
        
        try await sut.getMessages()
        
        XCTAssertTrue(sut.getMessagesCalled)
        XCTAssertNotNil(sut.messages)
        XCTAssertTrue(mockApiCaller.fetchCalled)
        XCTAssertEqual(mockApiCaller.fetchUrl, PathsUrl.messagesByUser(user: "bodoque").pathId)
    }

    // MARK: Make this test to proved mocked ApiFetcher
    func testMessagesByUser_getMessages_SuccessfulFetch() async throws {
        
        let expectation = XCTestExpectation(description: "Waiting for messages to be fetched")
        await exactViewModel.getMessages()
        expectation.fulfill()
        wait(for: [expectation], timeout: 2.5)
        XCTAssertNotNil(exactViewModel.messages)
    }
}
