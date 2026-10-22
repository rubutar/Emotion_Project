import Foundation

enum Intensity: Int, CaseIterable, Identifiable, Hashable {
    case low = 0
    case mid = 1
    case high = 2

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .low: return "Low"
        case .mid: return "Mid"
        case .high: return "High"
        }
    }
}
