import Foundation
import SwiftUI
import PhotosUI

@Observable
final class JournalViewModel {
    let emotion: Emotion
    let intensity: Intensity
    let store: JournalStore
    var prompt: String
    var entryText: String = ""
    var showCalendar: Bool = false
    
    var isPromptVisible: Bool = true
    
    var pickerItems: [PhotosPickerItem] = []
    var images: [UIImage] = []
   

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
