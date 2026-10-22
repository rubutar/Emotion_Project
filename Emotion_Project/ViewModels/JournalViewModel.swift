import Foundation

@Observable
final class JournalViewModel {
    let emotion: Emotion
    let intensity: Intensity
    let store: JournalStore
    let prompt: String
    var entryText: String = ""
    var showCalendar: Bool = false

    init(emotion: Emotion, intensity: Intensity, store: JournalStore) {
        self.emotion = emotion
        self.intensity = intensity
        self.store = store
        self.prompt = PromptsRepository.random(for: emotion, intensity: intensity)
    }

    func submit() {
        let entry = JournalEntry(
            emotion: emotion,
            intensity: intensity,
            text: entryText,
            date: Date()
        )
        store.add(entry)
        showCalendar = true
    }
}
