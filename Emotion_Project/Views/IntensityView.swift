import SwiftUI

struct IntensityView: View {
    @Environment(JournalStore.self) private var store
    @State var viewModel: IntensityViewModel

    // 0 = Low, 1 = Mid, 2 = High
    private var intensityName: String {
        switch Int(viewModel.sliderValue) {
        case 0: return "low"
        case 1: return "mid"
        default: return "high"
        }
    }

    // L'immagine dipende dall'emozione selezionata
    // e dal livello di intensità.
    private var imageName: String {
        "\(viewModel.emotion.title) \(intensityName)"
    }

    
    
    var body: some View {
        VStack {
            Text("How intense are your feelings?")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            Spacer()

            VStack(spacing: 28) {
                Image(imageName)
                    
                    .frame(width: 180, height: 180)
                    .animation(
                        .easeInOut(duration: 0.2),
                        value: viewModel.sliderValue
                    )

                Text(viewModel.intensity.title)
                    .font(.headline)

                Slider(
                    value: $viewModel.sliderValue,
                    in: 0...2,
                    step: 1
                )
                .tint(viewModel.emotion.color)
                .frame(width: 200, height: 44)
                .frame(width: 44, height: 200)

                
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 240)
            }

            Spacer()

            NavigationLink {
                JournalView(
                    viewModel: JournalViewModel(
                        emotion: viewModel.emotion,
                        intensity: viewModel.intensity,
                        store: store
                    )
                )
            } label: {
                Text("Next step")
                    .frame(maxWidth: .infinity)
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .tint(.black)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .navigationBarTitleDisplayMode(.inline)
        .animation(
            .easeInOut(duration: 0.2),
            value: viewModel.sliderValue
        )
    }
}

#Preview {
    NavigationStack {
        IntensityView(
            viewModel: IntensityViewModel(emotion: .happy)
        )
    }
    .environment(JournalStore())
}
