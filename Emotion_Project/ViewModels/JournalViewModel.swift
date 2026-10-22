import Foundation
import SwiftUI
import PhotosUI

@Observable
final class JournalViewModel {
    let emotion: Emotion
    let intensity: Intensity
    let store: JournalStore
    var prompt: String
    var titleText: String = ""
    var entryText: String = ""
    var showCalendar: Bool = false
    
    var isPromptVisible: Bool = true
    
    var pickerItems: [PhotosPickerItem] = []
    var images: [UIImage] = []

    private var existingId: UUID?

    init(emotion: Emotion, intensity: Intensity, store: JournalStore) {
        self.emotion = emotion
        self.intensity = intensity
        self.store = store
        self.prompt = PromptsRepository.random(for: emotion, intensity: intensity)

        if let existing = store.entries(on: Date()).first {
            self.titleText = existing.title
            self.entryText = existing.text
            self.existingId = existing.id
            self.images = existing.images.compactMap(UIImage.init(data:))
        }
    }

    func submit() {
        let entry = JournalEntry(
            id: existingId ?? UUID(),
            emotion: emotion,
            intensity: intensity,
            title: titleText,
            text: entryText,
            date: Date(),
            images: images.compactMap { $0.jpegData(compressionQuality: 0.8) }
        )
        store.upsert(entry)
        existingId = entry.id
        showCalendar = true
    }
    
    func refreshPrompt() {
        prompt = PromptsRepository.random(for: emotion, intensity: intensity)
    }
    
    func togglePrompt() {
        isPromptVisible.toggle()
    }
    
    func loadImages (from items: [PhotosPickerItem]) async {
        var loaded: [UIImage] = []
        for item in items {
            if let data = try? await item.loadTransferable(type: Data.self),
               let img = UIImage(data: data) {
                loaded.append(img)
            }
        }
        images = loaded
    }
}
