import Foundation

@Observable
final class JournalStore {
    var entries: [JournalEntry] = []

    func add(_ entry: JournalEntry) {
        entries.append(entry)
    }

    func entries(on date: Date) -> [JournalEntry] {
        let calendar = Calendar.current
        return entries.filter { calendar.isDate($0.date, inSameDayAs: date) }
    }
}
