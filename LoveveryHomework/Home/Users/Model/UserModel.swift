//
//  UserModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import Foundation

struct UserModel: Identifiable {
    var id = UUID().uuidString
    let username: String
}
