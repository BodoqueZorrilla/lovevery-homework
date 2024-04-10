//
//  TopicsView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 06/04/24.
//

import SwiftUI

struct TopicsView: View {
    @ObservedObject var viewModel: TopicsViewModel
    var body: some View {
        List {
            ForEach(viewModel.topics, id: \.rawValue) { topic in
                if topic != .none {
                    NavigationLink(destination: MessageByTopicView(viewModel: MessagesByTopicViewModel(topic: topic))) {
                        ListByItemView(showAvatar: false,
                                       byItemTitle: topic.rawValue.uppercased())
                    }.listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
    }
}

#if DEBUG
#Preview {
    TopicsView(viewModel: TopicsViewModel())
}
#endif
