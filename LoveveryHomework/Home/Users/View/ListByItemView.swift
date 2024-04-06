//
//  ListByItemView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 06/04/24.
//

import SwiftUI

struct ListByItemView: View {
    var showAvatar: Bool
    var byItemTitle: String
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if showAvatar {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 30))
            }
            HStack {
                Text(byItemTitle)
                    .padding()
                Spacer()
                
            }
            .background(Color("itemMessageColor", 
                              bundle: .main))
            .clipShape(.rect(cornerRadius: 6))
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
#Preview {
    ListByItemView(showAvatar: true, 
                   byItemTitle: "Sergio")
}
#endif
