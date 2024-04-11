//
//  NewMessageViewModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 08/04/24.
//

import SwiftUI
import Combine

final class NewMessageViewModel: ObservableObject {
    @Published var isGoodUsername: Bool = true
    @Published var isButtonEnabled = false
    @Published var userText: String = ""
    @Published var messageText: String = ""
    @Published var topicSelected: TopicsOptions = .none
    @Published var showError: Bool = false
    var shouldDismissPublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismiss = false {
        didSet {
            DispatchQueue.main.async(execute: { [weak self] in
                self?.shouldDismissPublisher.send(self?.shouldDismiss ?? false)
            })
        }
    }
    private let regexPattern = "^[a-zA-Z0-9\\s_.-]*$"
    private var apiCaller = ApiFetcher()

    func limitText(_ text: String, with limit: Int) -> String {
        let result = text.range(
            of: regexPattern,
            options: .regularExpression
        )
        let validText = (result != nil)
        validAddEnabled(validText: validText)
        return text.count > limit ? String(text.prefix(limit)) : text
    }

    func changeTopic(topic: TopicsOptions) {
        topicSelected = topic
        validAddEnabled(validText: true)
    }

    private func validAddEnabled(validText: Bool) {
        isButtonEnabled = userText.count > 3 && validText && messageText.count > 5 && topicSelected != .none
    }

    func dissmissView() {
        shouldDismiss = true
    }

    func postMessage() async {
        let message = NewMessageModel(user: userText,
                                      operation: .addMessage,
                                      subject: topicSelected.rawValue,
                                      message: messageText)
        let response = await apiCaller.postInfo(type: ApiResponse.self, encoder: message, from: PathsUrl.messages.pathId)
        if let response = response {
            if response.statusCode == 200 {
                dissmissView()
            } else {
                showError = true
            }
        } else {
            showError = true
        }
    }
}
