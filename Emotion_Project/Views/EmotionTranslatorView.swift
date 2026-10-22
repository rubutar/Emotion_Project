import SwiftUI

struct EmotionTranslatorView: View {
    @State private var viewModel = EmotionTranslatorViewModel()
   
    private let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.emotions) { emotion in
                        NavigationLink {
                            IntensityView(
                                viewModel: IntensityViewModel(emotion: emotion)
                            )
                        } label: {
                            VStack( spacing: 16) {
                                Image(emotion.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height:160)
                                
                            
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 140)
                            .background(emotion.color.opacity(0.12))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 16)
                            )
                            .contentShape(
                                RoundedRectangle(cornerRadius: 16)
                            )
                            
                        }
                        .buttonStyle(.plain)
                        
                    }
                } .padding()
            }
            .navigationTitle("How are you feeling?")
        }
    }
}

#Preview {
    EmotionTranslatorView()
}
