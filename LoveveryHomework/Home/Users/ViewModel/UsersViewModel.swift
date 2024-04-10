//
//  UsersViewModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 08/04/24.
//

import Foundation

final class UsersViewModel: ObservableObject {
    @Published var users = [UserModel]()
    private var apiCaller = ApiFetcher()
    
    func getUsers() async {
        guard let users = await apiCaller.fetch(type: ApiResponse.self, from: PathsUrl.messages.pathId),
              let messages = users.body.toDictionary() else { return }
        for (key, _) in messages {
            DispatchQueue.main.async { [weak self] in
                self?.users.append(UserModel(username: key))
            }
        }
    }
}
