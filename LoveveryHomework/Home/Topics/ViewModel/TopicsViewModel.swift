//
//  TopicsViewModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 10/04/24.
//

import Foundation

final class TopicsViewModel: ObservableObject {
    @Published var topics = TopicsOptions.allCases
}
