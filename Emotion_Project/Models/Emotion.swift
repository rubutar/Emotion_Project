import Foundation

enum Emotion: String, CaseIterable, Identifiable, Hashable {
    case happy
    case lonely
    case anxious
    case overwhelmed
    case sad
    case drained
    case angry

    var id: String { rawValue }

    var title: String { rawValue.capitalized }
}
