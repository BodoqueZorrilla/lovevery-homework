//
//  MessagesByUserMocks.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 11/04/24.
//

import Foundation
@testable import LoveveryHomework

protocol MockMessagesViewModel: MessagesByUserViewModelProtocol {
    var getMessagesCalled: Bool { get set }
    var getMessagesCompletion: ((MessagesFetchResult) -> Void)? { get set }

    func getMessages() async throws
}

enum MessagesFetchResult {
    case success(MessagesByUser)
    case failure(Error)
}

final class MessagesByUserMocks: MockMessagesViewModel {
    var getMessagesCalled = false
    var getMessagesCompletion: ((MessagesFetchResult) -> Void)?
    var messages: MessagesByUser?
    private let apiCaller: MockApiFetcherMessages

    init(apiCaller: MockApiFetcherMessages) {
      self.apiCaller = apiCaller
    }

    func getMessages() async throws {
        getMessagesCalled = true
        messages = try await apiCaller.fetchMock(type: MessagesByUser.self, from: "/messages/bodoque")
    }
}

final class MockApiFetcherMessages: ApiFetcherProtocol {

    
    var fetchCalled = false
    var fetchUrl: String?
    var fetchCompletion: ((FetchResult<ApiResponse>) -> Void)?
    private var responseMocked = ApiResponse(statusCode: 200, body: "{\"user\": \"dan\", \"message\": [{\"subject\": \"pets\", \"message\": \"cats are grumpy\"}]}")
    private let mockResponseData = "{\"user\": \"bodoque\", \"message\": [{\"subject\": \"pets\", \"message\": \"cats are grumpy\"}]}"
    
    func fetch<T>(type: T.Type, from urlString: String) async -> T? {
        fetchCalled = true
        fetchUrl = urlString
        return responseMocked as? T
    }

    func fetchMock<T>(type: T.Type, from url: String) async throws -> T {
        fetchCalled = true
        fetchUrl = url
        guard let completion = fetchCompletion else { throw NSError(domain: "mock", code: 500) }
        completion(.success(ApiResponse(statusCode: 200, body: mockResponseData)))
        
        var messagesArray = [Message]()
        for (_, value) in mockResponseData.toDictionary()! {
            if let dictionaryData = value as? Array<Any> {
                messagesArray = getMessagesOfAny(data: dictionaryData) ?? [Message]()
            }
        }
        return MessagesByUser(username: "bodoque", messages: messagesArray) as! T
    }

    private func getMessagesOfAny(data: Array<Any>) -> [Message]? {
        var messageArray = [Message]()
        for nData in data {
            if let dictionary = nData as? [String: Any] {
                guard let message = dictionary["message"] as? String,
                      let subject = dictionary["subject"] as? String else {
                    return nil
                }
                messageArray.append(Message(subject: subject, message: message))
            }
        }
        return messageArray
    }
}
