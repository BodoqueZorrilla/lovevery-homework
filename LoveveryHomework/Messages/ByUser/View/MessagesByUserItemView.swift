//
//  MessagesByUserItemView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import SwiftUI

struct MessagesByUserItemView: View {
    var message: Message
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 30))
            VStack(alignment: .leading) {
                Text("\(message.subject):")
                    .font(.system(.body, weight: .bold))
                    .padding([.trailing, .leading, .top])
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(message.message)
                    .padding([.trailing, .leading, .bottom])
                
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
    MessagesByUserItemView(message: Message(subject: "Football", message: "Chelase is the best team Chelase is the best team Chelase is the best team Chelase is the best team Chelase is the best team Chelase is the best team"))
}
#endif
