//
//  MessageByTopicView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import SwiftUI

struct MessageByTopicView: View {
    @ObservedObject var viewModel: MessagesByTopicViewModel
    var body: some View {
        VStack {
            if viewModel.messages.isEmpty {
                Text("No messages in this Topic")
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .bold))
            } else {
                List(viewModel.messages) { message in
                    MessageByTopicItemView(userMessage: message)
                        .listRowSeparator(.hidden)
                }.listStyle(.plain)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonView())
        .navigationTitle(viewModel.getTitle())
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

#if DEBUG
#Preview {
    MessageByTopicView(viewModel: MessagesByTopicViewModel(topic: .dogs, 
                                                           apiFetcher: ApiFetcher()))
}
#endif
