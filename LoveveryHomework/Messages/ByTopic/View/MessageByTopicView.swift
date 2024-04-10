//
//  MessageByTopicView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import SwiftUI

struct MessageByTopicView: View {

    var body: some View {
        List(names) { message in
            MessageByTopicItemView()
                .listRowSeparator(.hidden)
        }.listStyle(.plain)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButtonView())
            .navigationTitle("Football")
//            .onAppear {
//                Task {
//                    await viewModel.getMessages()
//                }
//            }
    }
}

#if DEBUG
#Preview {
    MessageByTopicView()
}
#endif
