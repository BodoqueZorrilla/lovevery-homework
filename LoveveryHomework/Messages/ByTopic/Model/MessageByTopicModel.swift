//
//  MessageByTopicModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 10/04/24.
//

import Foundation

struct UserMessageByTopic: Identifiable, Codable {
    var id = UUID().uuidString
    let username: String
    let messages: [Message]
}
