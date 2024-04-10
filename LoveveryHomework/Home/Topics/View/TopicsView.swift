//
//  TopicsView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 06/04/24.
//

import SwiftUI

struct TopicsView: View {
    var body: some View {
        List {
            ForEach(TopicsOptions.allCases, id: \.rawValue) { topic in
                if topic != .none {
                    NavigationLink(destination: MessageByTopicView()) {
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
    TopicsView()
}
#endif
