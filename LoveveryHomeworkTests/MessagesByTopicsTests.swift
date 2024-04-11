//
//  MessagesByTopicsTests.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 11/04/24.
//

import XCTest
@testable import LoveveryHomework

final class MessagesByTopicsTests: XCTestCase {
    private var mockApiCaller: MockApiFetcherMessagesByTopic!
    private var sut: MessagesByTopicViewModel!
    
    override func setUpWithError() throws {
        mockApiCaller = MockApiFetcherMessagesByTopic()
        sut = MessagesByTopicViewModel(topic: .football, apiFetcher: mockApiCaller)
    }
    
    override func tearDownWithError() throws {
        mockApiCaller = nil
        sut = nil
    }
    
    // MARK: Make this test to proved mocked ApiFetcher
    func testMessagesByTopic_getMessages_SuccessfulFetch() async throws {
        
        let expectation = XCTestExpectation(description: "Waiting for messages by Topic to be fetched")
        await sut.fetchData()
        expectation.fulfill()
        wait(for: [expectation], timeout: 2.5)
        XCTAssertNotNil(sut.messages)
    }
}
