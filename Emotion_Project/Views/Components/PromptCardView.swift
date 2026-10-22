import SwiftUI

struct PromptCardView: View {
    let prompt: String

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.gray.opacity(0.15))
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
                            
                        } label: {
                            Label("Try another prompt", systemImage: "arrow.clockwise")
                        }
                        Spacer()
                        Button {
                            
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
    PromptCardView(prompt: "What's going well that you want to remember?")
        .padding()
}
