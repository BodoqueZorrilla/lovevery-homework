//
//  MessageByTopicMocks.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 11/04/24.
//

import Foundation
@testable import LoveveryHomework

final class MockApiFetcherMessagesByTopic: ApiFetcherProtocol {
    private var responseMocked = ApiResponse(statusCode: 200,
                                             body: "{\"bodoque\": [{\"subject\": \"football\", \"message\": \"cats are grumpy\"}, {\"subject\": \"football\", \"message\": \"cats are grumpy\"}, {\"subject\": \"football\", \"message\": \"cats are grumpy\"}], \"bodoque1\": [{\"subject\": \"football\", \"message\": \"cats are grumpy\"}]}")
    func fetch<T>(type: T.Type, from urlString: String) async -> T? {
        return responseMocked as? T
    }
}
