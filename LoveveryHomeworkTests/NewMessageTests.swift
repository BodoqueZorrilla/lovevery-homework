//
//  NewMessageTests.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 12/04/24.
//

import XCTest
@testable import LoveveryHomework

final class NewMessageTests: XCTestCase {
    private var sut: MockNewMessageMock!
    private var mockApiCaller: MockApiFetcherPost!
    
    override func setUpWithError() throws {
        mockApiCaller = MockApiFetcherPost()
        sut =  MockNewMessageMock(apiCaller: mockApiCaller)
    }
    
    override func tearDownWithError() throws {
        mockApiCaller = nil
        sut = nil
    }
    
    func test_PostMessage() async throws {
        try await sut.postMessage()
        XCTAssertTrue(sut.getNewMessageCalled)
        XCTAssertTrue(mockApiCaller.postCalled)
    }

    func test_ValitLimit() async throws {
        let limit = sut.limitText("Bodoque", with: 3)
        XCTAssertTrue(sut.limitTextCalled)
        XCTAssertEqual("Bod", limit)
    }

    func test_ChangeTopic() async throws {
        sut.changeTopic(topic: .football)
        XCTAssertTrue(sut.changeTopicCalled)
    }

    func test_DissmissScreen() async throws {
        sut.dissmissView()
        XCTAssertTrue(sut.dismissViewCalled)
    }
}
