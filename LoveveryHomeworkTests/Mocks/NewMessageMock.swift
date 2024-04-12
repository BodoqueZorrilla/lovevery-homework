//
//  NewMessageMock.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 12/04/24.
//

import Foundation
@testable import LoveveryHomework

protocol MockNewMessageViewModel: NewMessageViewModelProtocol {
    var getNewMessageCalled: Bool { get set }
    func limitText(_ text: String, with limit: Int) -> String
    func changeTopic(topic: TopicsOptions)
    func dissmissView()
    func postMessage() async throws
}

final class MockNewMessageMock: MockNewMessageViewModel {
    var getNewMessageCalled = false
    var limitTextCalled = false
    var changeTopicCalled = false
    var dismissViewCalled = false
    private let apiCaller: MockApiFetcherPost
    
    init(apiCaller: MockApiFetcherPost) {
        self.apiCaller = apiCaller
    }
    
    func postMessage() async throws {
        getNewMessageCalled = true
        let message = NewMessageModel(user: "bodoque",
                                      operation: .addMessage,
                                      subject: "pets",
                                      message: "dogs are good")
        try await apiCaller.postInfo(type: ApiResponse.self, encoder: message, from: "messages")
    }

    func limitText(_ text: String, with limit: Int) -> String {
        limitTextCalled = true
        return text.count > limit ? String(text.prefix(limit)) : text
    }
    
    func changeTopic(topic: TopicsOptions) {
        changeTopicCalled = true
    }
    
    func dissmissView() {
        dismissViewCalled = true
    }
}

final class MockApiFetcherPost {
    var postCalled = false
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    func postInfo<T: Codable, E: Encodable>(type: T.Type, encoder: E, from urlString: String) async -> T? {
        postCalled = true
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let data = try JSONEncoder().encode(encoder)
            guard let response = try await postData(url: url, with: data) else { return nil }
            return try decoder.decode(type, from: response)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func postData(url: URL, with data: Data) async throws -> Data? {
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json; charset=UTF-8",
                            forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("*/*", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data
        let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: data)
        
        print("HTTPURLResponse:", response)
        print("The response body is:", String(decoding: data, as: UTF8.self))
        return data
    }
}
