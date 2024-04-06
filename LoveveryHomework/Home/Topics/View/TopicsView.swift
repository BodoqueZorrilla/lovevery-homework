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
            ForEach(1..<4) { _ in
                ListByItemView(showAvatar: false,
                               byItemTitle: "Cars")
                    .listRowSeparator(.hidden)
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
