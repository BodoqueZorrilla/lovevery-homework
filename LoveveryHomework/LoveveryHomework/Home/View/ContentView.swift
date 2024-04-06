//
//  ContentView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 06/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                TabView {
                    UsersView()
                        .tabItem {
                            Label("Users", systemImage: "person")
                        }
                    TopicsView()
                        .tabItem {
                            Label("Topics", systemImage: "message.and.waveform.fill")
                        }
                }
                .tint(.black)
                .overlay(
                    VStack {
                        Divider().offset(x: 0, y: 30)
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .tint(Color.white)
                        }
                        .frame(width: 70, height: 40)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.startGradiant, .endGradiant]),
                                           startPoint:.topTrailing,
                                           endPoint: .bottomLeading)
                            )
                        .clipShape(.rect(cornerRadius: 20))
                       
                    }.position(x: geo.size.width / 2,
                               y: geo.size.height - 100)
                )
                .navigationTitle("Lovevery HM")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#if DEBUG
#Preview {
    ContentView()
}
#endif
