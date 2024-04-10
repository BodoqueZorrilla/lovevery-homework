//
//  UsersView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 06/04/24.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel: UsersViewModel
    var body: some View {
        VStack {
            if viewModel.users.isEmpty {
                Text("Please add a message about the topic you like")
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .bold))
            } else {
                List(viewModel.users) { user in
                    NavigationLink(destination: MessagesByUserView(viewModel: MessagesByUserViewModel(user: user.username))) {
                        ListByItemView(showAvatar: true,
                                       byItemTitle: user.username)
                        
                    }.listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            viewModel.users.removeAll()
            Task {
                await viewModel.getUsers()
            }
        }
    }
}

#if DEBUG
#Preview {
    UsersView(viewModel: UsersViewModel())
}
#endif
