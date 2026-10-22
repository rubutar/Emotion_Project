import Foundation

struct JournalEntry: Identifiable, Hashable {
    let id: UUID
    let emotion: Emotion
    let intensity: Intensity
    let title: String
    let text: String
    let date: Date
    let images: [Data]

    init(
        id: UUID = UUID(),
        emotion: Emotion,
        intensity: Intensity,
        title: String = "",
        text: String,
        date: Date,
        images: [Data] = []
    ) {
        self.id = id
        self.emotion = emotion
        self.intensity = intensity
        self.title = title
        self.text = text
        self.date = date
        self.images = images
    }
}
