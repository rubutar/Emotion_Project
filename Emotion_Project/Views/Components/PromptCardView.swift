import SwiftUI

struct PromptCardView: View {
    let prompt: String
    let tint: Color
    let onRefresh: () -> Void
    let onHide:() -> Void

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(tint.opacity(0.15))
            .frame(minHeight: 140)
            .overlay(
                VStack{
                    Text(prompt)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                    HStack{
                        Button {
                            onRefresh()
                        } label: {
                            Label("Try another prompt", systemImage: "arrow.clockwise")
                        }
                        Spacer()
                        Button {
                            onHide()
                        } label: {
                            Label("Hide the prompt", systemImage: "chevron.backward")
                        }
                    }
                    
                }
            )
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    PromptCardView(prompt: "What's going well that you want to remember?", tint: .yellow, onRefresh: {}, onHide: {})
        .padding()
}
