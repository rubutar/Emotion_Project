import Foundation
import SwiftUI

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
    
    var imageName: String {
            switch self {
            case .happy: return "Happy"
            case .lonely: return "Lonely"
            case .anxious: return "Anxious"
            case .overwhelmed: return "Overwhelmed"
            case .sad: return "Sad"
            case .drained: return "Drained"
            case .angry: return "Angry"
            }
        }
    
    var color: Color {
        switch self {
        case .happy:       return .yellow
        case .lonely:      return .green
        case .anxious:     return .orange
        case .overwhelmed: return .purple
        case .sad:         return .blue
        case .drained:     return .teal
        case .angry:       return .red
        }
    }
}
