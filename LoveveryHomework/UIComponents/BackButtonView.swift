//
//  BackButtonView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }
}

#if DEBUG
#Preview {
    BackButtonView()
}
#endif
