//
//  UsersMocks.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 11/04/24.
//

import Foundation
@testable import LoveveryHomework

protocol MockUsersViewModel: UsersViewModelProtocol {
    var getUsersCalled: Bool { get set }
    var getUsersCompletion: ((UsersFetchResult) -> Void)? { get set }

    func getUsers() async throws
}

enum UsersFetchResult {
    case success([UserModel])
    case failure(Error)
}

final class MockUsersViewModelMock: MockUsersViewModel {
    var getUsersCalled = false
    var getUsersCompletion: ((UsersFetchResult) -> Void)?
    var users = [UserModel]()
    private let apiCaller: MockApiFetcher // Inject ApiFetcher here

    init(apiCaller: MockApiFetcher) { // New initializer
      self.apiCaller = apiCaller
    }

    func getUsers() async throws {
        getUsersCalled = true
        try await apiCaller.fetch(type: [UserModel].self, from: "/messages")
    }
}

enum FetchResult<T> {
    case success(T)
    case failure(Error)
}

final class MockApiFetcher {
    var fetchCalled = false
    var fetchUrl: String?
    var fetchCompletion: ((FetchResult<ApiResponse>) -> Void)?

    func fetch<T>(type: T.Type, from url: String) async throws -> T {
        fetchCalled = true
        fetchUrl = url
        let mockResponseData = "{\"bodoque\": [{\"subject\": \"pets\", \"message\": \"cats are grumpy\"}, {\"subject\": \"pets\", \"message\": \"cats are grumpy\"}, {\"subject\": \"pets\", \"message\": \"cats are grumpy\"}], \"bodoque1\": [{\"subject\": \"pets\", \"message\": \"cats are grumpy\"}]}" // Example data structure
        guard let completion = fetchCompletion else { throw NSError(domain: "mock", code: 500) }
        completion(.success(ApiResponse(statusCode: 200, body: mockResponseData)))
        var users = [UserModel]()
        
        for (key, _) in mockResponseData.toDictionary()! {
            users.append(UserModel(username: key))
        }
        return try users as! T
    }
}
