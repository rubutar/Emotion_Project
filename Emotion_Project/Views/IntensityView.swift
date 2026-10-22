import SwiftUI

struct IntensityView: View {
    @Environment(JournalStore.self) private var store
    @State var viewModel: IntensityViewModel

    var body: some View {
        VStack(spacing: 32) {
            Text(viewModel.emotion.title)
                .font(.largeTitle)
                .bold()

            VStack(spacing: 8) {
                Text("Intensity: \(viewModel.intensity.title)")
                    .font(.headline)
                Slider(value: $viewModel.sliderValue, in: 0...2, step: 1)
                HStack {
                    Text("Low")
                    Spacer()
                    Text("Mid")
                    Spacer()
                    Text("High")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal)

            NavigationLink("Continue") {
                JournalView(
                    viewModel: JournalViewModel(
                        emotion: viewModel.emotion,
                        intensity: viewModel.intensity,
                        store: store
                    )
                )
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding(.top, 48)
        .navigationTitle("Intensity")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        IntensityView(viewModel: IntensityViewModel(emotion: .happy))
    }
    .environment(JournalStore())
}
