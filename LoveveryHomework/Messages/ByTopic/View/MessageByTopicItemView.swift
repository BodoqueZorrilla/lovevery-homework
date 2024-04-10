//
//  MessageByTopicItemView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import SwiftUI

struct MessageByTopicItemView: View {
    var userMessage: UserMessageByTopic
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 30))
            VStack(alignment: .leading) {
                Text("\(userMessage.username):")
                    .font(.system(.body, weight: .bold))
                    .padding([.trailing, .leading, .top])
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(userMessage.messages) { message in
                    Text(message.message)
                        .padding([.trailing, .leading, .bottom])
                }
            }
            .background(Color("itemMessageColor",
                              bundle: .main))
            .clipShape(.rect(cornerRadius: 6))
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
#Preview {
    MessageByTopicItemView(userMessage: UserMessageByTopic(username: "Bodoque", 
                                                           messages: [Message(subject: "Pets", message: "dogs love people")]))
}
#endif
