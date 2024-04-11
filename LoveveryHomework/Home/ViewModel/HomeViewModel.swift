//
//  HomeViewModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 08/04/24.
//

import Foundation

protocol HomeViewModelProtocol {
    func showAddNewMessageScreen(show: Bool)
    func reloadUsersMessages() async throws
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    @Published var showSheetPresented = false
    @Published var usersViewModel = UsersViewModel()
    @Published var topicsViewModel = TopicsViewModel()

    func showAddNewMessageScreen(show: Bool) {
        showSheetPresented = show
    }

    func reloadUsersMessages() {
        Task {
            await usersViewModel.getUsers()
        }
    }
}
