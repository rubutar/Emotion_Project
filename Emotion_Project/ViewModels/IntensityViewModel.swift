import Foundation

@Observable
final class IntensityViewModel {
    let emotion: Emotion
    var sliderValue: Double = 1

    init(emotion: Emotion) {
        self.emotion = emotion
    }

    var intensity: Intensity {
        Intensity(rawValue: Int(sliderValue.rounded())) ?? .mid
    }
}
