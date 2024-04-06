//
//  UsersView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 06/04/24.
//

import SwiftUI

struct UsersView: View {
    var body: some View {
        List {
            ForEach(1..<4) { _ in
                ListByItemView(showAvatar: true, 
                               byItemTitle: "Sergio")
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}

#if DEBUG
#Preview {
    UsersView()
}
#endif
