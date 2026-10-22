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
        case .happy:       return "Button - Happy"
        case .lonely:      return "Button - Lonely"
        case .anxious:     return "Button - Anxious"
        case .overwhelmed: return "Button - Overwhelmed"
        case .sad:         return "Button - Sad"
        case .drained:     return "Button - Drained"
        case .angry:       return "Button - Angry"
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
