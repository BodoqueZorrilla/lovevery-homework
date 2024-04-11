//
//  MessagesByUserView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import SwiftUI

struct MessagesByUserView: View {
    @ObservedObject var viewModel: MessagesByUserViewModel

    var body: some View {
        List(viewModel.messages?.messages ?? [Message]()) { message in
            MessagesByUserItemView(message: message)
                .listRowSeparator(.hidden)
        }.listStyle(.plain)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButtonView())
            .navigationTitle(viewModel.messages?.username ?? "")
            .onAppear {
                Task {
                    await viewModel.getMessages()
                }
            }
    }
}

#if DEBUG
#Preview {
    MessagesByUserView(viewModel: MessagesByUserViewModel(user: "Bodoque", 
                                                          apiFetcher: ApiFetcher()))
}
#endif
