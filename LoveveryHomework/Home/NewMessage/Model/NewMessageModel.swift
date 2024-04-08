//
//  NewMessageModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 08/04/24.
//

import Foundation

enum TopicsOptions: String, CaseIterable {
    case none = "<>"
    case football
    case dogs
    case cats
    case toys
    case technology
    case kids
}

struct NewMessageModel: Codable {
    var user: String
    var operation: OperationsPost
    var subject: String
    var message: String
}

enum OperationsPost: String, Codable {
    case addMessage = "add_message"
}
