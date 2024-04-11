//
//  MessagesByUserModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import Foundation

struct MessagesByUser: Codable {
    let username: String
    let messages: [Message]
}
