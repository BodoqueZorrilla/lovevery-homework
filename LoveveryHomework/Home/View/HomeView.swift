//
//  HomeView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 06/04/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                TabView {
                    UsersView(viewModel: viewModel.usersViewModel)
                        .tabItem {
                            Label("Users", systemImage: "person")
                        }
                    TopicsView(viewModel: viewModel.topicsViewModel)
                        .tabItem {
                            Label("Topics", systemImage: "message.and.waveform.fill")
                        }
                }
                .tint(.black)
                .overlay(
                    addButtonView(proxy: geo)
                )
                .navigationTitle("Lovevery HM")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $viewModel.showSheetPresented,
                       onDismiss: {
                    viewModel.reloadUsersMessages()
                    viewModel.showAddNewMessageScreen(show: false)
                }, content: {
                    NewMessageView(viewModel: NewMessageViewModel())
                })
            }
        }
    }
    
    private func addButtonView(proxy: GeometryProxy) -> some View {
        VStack {
            Divider().offset(x: 0, y: 30)
            Button {
                viewModel.showAddNewMessageScreen(show: true)
            } label: {
                Image(systemName: "plus").tint(Color.white)
            }
            .frame(width: 70, height: 40)
            .background(
                LinearGradient(gradient: Gradient(colors: [.startGradiant, .endGradiant]),
                               startPoint:.topTrailing,
                               endPoint: .bottomLeading)
            )
            .clipShape(.rect(cornerRadius: 20))
        }.position(x: proxy.size.width / 2,
                   y: proxy.size.height - 100)
    }
}

#if DEBUG
#Preview {
    HomeView(viewModel: HomeViewModel())
}
#endif
