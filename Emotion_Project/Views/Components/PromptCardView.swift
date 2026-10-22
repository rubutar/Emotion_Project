import SwiftUI

struct PromptCardView: View {
    let prompt: String
    let tint: Color
    let onRefresh: () -> Void
    let onHide: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(prompt)
                .font(.title3)
                .fontWeight(.medium)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)

            HStack {
                Button {
                    onRefresh()
                } label: {
                    Label("Try another prompt", systemImage: "arrow.clockwise")
                        .font(.subheadline)
                }
                .foregroundStyle(.primary)

                Spacer()

                Button {
                    onHide()
                } label: {
                    Label("Hide prompt", systemImage: "chevron.up")
                        .font(.subheadline)
                }
                .foregroundStyle(.secondary)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(tint.opacity(0.18))
        )
    }
}

#Preview {
    PromptCardView(
        prompt: "What's going well that you want to remember?",
        tint: .yellow,
        onRefresh: {},
        onHide: {}
    )
    .padding()
}
