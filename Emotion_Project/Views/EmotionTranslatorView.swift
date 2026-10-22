import SwiftUI

struct EmotionTranslatorView: View {
    @State private var viewModel = EmotionTranslatorViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.emotions) { emotion in
                NavigationLink(emotion.title) {
                    IntensityView(viewModel: IntensityViewModel(emotion: emotion))
                }
            }
            .navigationTitle("How are you feeling?")
        }
    }
}

#Preview {
    EmotionTranslatorView()
}
