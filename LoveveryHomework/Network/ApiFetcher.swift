//
//  ApiFetcher.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 08/04/24.
//

import Foundation

struct ApiFetcher {
    private let mainURL = "https://abraxvasbh.execute-api.us-east-2.amazonaws.com/proto"
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    func fetch<T: Decodable>(type: T.Type, from urlString: String) async -> T? {
        let completeURL = mainURL + urlString
        guard let url = URL(string: completeURL) else { return nil }
        do {
            let (data, _) = try await URLSession
                .shared
                .data(from: url)
            return try decoder.decode(type, from: data)
        } catch {
            print("Info could not be decoded: \(error)")
            return nil
        }
    }
    
    func postInfo<T: Codable, E: Encodable>(type: T.Type, encoder: E, from urlString: String) async -> T? {
        let completeURL = mainURL + urlString
        guard let url = URL(string: completeURL) else { return nil }

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

struct ApiResponse: Codable {
    let statusCode: Int
    let body: String
}

enum PathsUrl {
    case messages
    case messagesByUser(user: String)
    
    var pathId: String {
        switch self {
        case .messages:
            return "/messages"
        case .messagesByUser(let user):
            return "/messages/\(user)"
        }
    }
}
