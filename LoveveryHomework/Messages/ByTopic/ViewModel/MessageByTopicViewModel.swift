//
//  MessageByTopicViewModel.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 10/04/24.
//

import Foundation

final class MessagesByTopicViewModel: ObservableObject {
    @Published var messages = [UserMessageByTopic]()
    private let apiCaller: ApiFetcherProtocol
    private var topic: TopicsOptions
    private var hasMessages = false
    init(topic: TopicsOptions, apiFetcher: ApiFetcherProtocol) {
        self.topic = topic
        self.apiCaller = apiFetcher
    }

    func getTitle() -> String {
        topic.rawValue.uppercased()
    }
    
    func fetchData() async {
        guard let data = await apiCaller.fetch(type: ApiResponse.self, from: PathsUrl.messages.pathId),
              let response = data.body.toDictionary() else { return }

        var allMessagesArray = [UserMessageByTopic]()
        for (key, value) in response {
            hasMessages = false
            var messagesArray = [Message]()
            if let dictionaryData = value as? Array<Any> {
                messagesArray = getMessagesOfAny(data: dictionaryData) ?? [Message]()
                if hasMessages {
                    allMessagesArray.append(UserMessageByTopic(username: key, messages: messagesArray))
                }
            }
        }
        let copyArray = allMessagesArray
        DispatchQueue.main.async { [weak self] in
            self?.messages = copyArray
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
                if subject == topic.rawValue {
                    hasMessages = true
                    messageArray.append(Message(subject: subject, message: message))
                }
            }
        }
        return messageArray
    }
}
