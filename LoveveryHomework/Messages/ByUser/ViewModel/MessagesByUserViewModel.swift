//
//  MessagesByUserViewModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import Foundation

final class MessagesByUserViewModel: ObservableObject {
    @Published var messages: MessagesByUser?
    private let apiCaller = ApiFetcher()
    private var user: String
    
    init(user: String) {
        self.user = user
    }
    
    func getMessages() async {
        guard let response = await apiCaller.fetch(type: ApiResponse.self, from: PathsUrl.messagesByUser(user: user).pathId),
              let responseToDictionary = response.body.toDictionary() else { return }
        var messagesArray = [Message]()
        for (_, value) in responseToDictionary {
            if let dictionaryData = value as? Array<Any> {
                messagesArray = getMessagesOfAny(data: dictionaryData) ?? [Message]()
            }
        }
        let copyOfArray = messagesArray
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.messages = MessagesByUser(username: self.user, messages: copyOfArray)
        }
    }

    private func getMessagesOfAny(data: Array<Any>) -> [Message]? {
        var messageArray = [Message]()
        for nData in data {
            if let dictionary = nData as? [String: Any] {
                guard let message = dictionary["message"] as? String,
                      let subject = dictionary["subject"] as? String else {
                    return nil
                }
                messageArray.append(Message(subject: subject, message: message))
            }
        }
        return messageArray
    }
}
