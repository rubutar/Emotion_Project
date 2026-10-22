import Foundation

@Observable
final class EmotionTranslatorViewModel {
    let emotions: [Emotion] = Emotion.allCases
}
