import Foundation

@Observable
final class CalendarViewModel {
    let store: JournalStore
    var selectedDate: Date = Date()

    init(store: JournalStore) {
        self.store = store
    }

    var entriesForSelectedDate: [JournalEntry] {
        store.entries(on: selectedDate)
    }
}
