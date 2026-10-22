import Foundation

struct JournalEntry: Identifiable, Hashable {
    let id: UUID
    let emotion: Emotion
    let intensity: Intensity
    let text: String
    let date: Date

    init(
        id: UUID = UUID(),
        emotion: Emotion,
        intensity: Intensity,
        text: String,
        date: Date
    ) {
        self.id = id
        self.emotion = emotion
        self.intensity = intensity
        self.text = text
        self.date = date
    }
}
