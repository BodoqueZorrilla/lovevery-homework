//
//  HomeViewModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 08/04/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var showSheetPresented = false

    func showAddNewMessageScreen(show: Bool) {
        showSheetPresented = show
    }
}
