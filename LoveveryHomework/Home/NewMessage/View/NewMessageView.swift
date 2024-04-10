//
//  NewMessageView.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 08/04/24.
//

import SwiftUI

struct NewMessageView: View {
    @ObservedObject var viewModel: NewMessageViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color("itemMessageColor").ignoresSafeArea()
                inputsMessageView()
            }
            .navigationTitle("New Message")
            .toolbar(.visible)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        viewModel.dissmissView()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        Task {
                            await viewModel.postMessage()
                        }
                    }
                        .disabled(!viewModel.isButtonEnabled)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .interactiveDismissDisabled()
        .onReceive(viewModel.shouldDismissPublisher, perform: { dismiss in
            self.dismiss()
        })
    }

    private func topicsMenuView() -> some View {
        Menu {
            ForEach(TopicsOptions.allCases, id: \.rawValue) { topic in
                Button(topic.rawValue.uppercased()) {
                    viewModel.changeTopic(topic: topic)
                }
                .disabled(topic == .none)
            }
        } label: {
            HStack(alignment: .center) {
                Text("Topic")
                Spacer()
                Text(viewModel.topicSelected.rawValue)
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
        }
    }

    private func inputsMessageView() -> some View {
        VStack(spacing: 10) {
            TextField("User",
                      text: $viewModel.userText)
            .onChange(of: viewModel.userText, { _, newValue in
                viewModel.userText = viewModel.limitText(newValue,
                                                         with: 15)
            })
            .padding()
            topicsMenuView()
            TextField("Message", text: $viewModel.messageText, axis: .vertical)
                .lineLimit(5...10)
                .padding()
                .onChange(of: viewModel.messageText, { _, newValue in
                    viewModel.messageText = viewModel.limitText(newValue,
                                                                with: 60)
                })
        }
        .textFieldStyle(.roundedBorder)
        .background(.white)
        .clipShape(.rect(cornerRadius: 16))
        .padding()
    }
}

#if DEBUG
#Preview {
    NewMessageView(viewModel: NewMessageViewModel())
}
#endif
