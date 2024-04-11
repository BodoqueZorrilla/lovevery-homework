//
//  HomeMocks.swift
//  LoveveryHomeworkTests
//
//  Created by Sergio Eduardo Zorilla Arellano on 10/04/24.
//

import Foundation
@testable import LoveveryHomework

final class MockHomeViewModel: HomeViewModelProtocol {
    var isShowingMessage = false
    var isReloadMessages = false
    func showAddNewMessageScreen(show: Bool) {
        isShowingMessage = show
    }
    
    func reloadUsersMessages() async throws {
        isReloadMessages = true
    }
}
