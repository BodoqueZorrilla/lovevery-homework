//
//  HomeViewModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 08/04/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var showSheetPresented = false
    @Published var usersViewModel = UsersViewModel()

    func showAddNewMessageScreen(show: Bool) {
        showSheetPresented = show
    }

    func reloadUsersMessages() {
        Task {
            await usersViewModel.getUsers()
        }
    }
}
