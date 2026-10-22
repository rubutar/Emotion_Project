import Foundation

enum PromptsRepository {
    private static let happy: [Intensity: [String]] = [
        .low: [
            "Nice. What made you smile today?",
            "Good to hear. What's going okay right now?",
            "Love that. Who were you with?",
            "Sweet. What song fits this mood?"
        ],
        .mid: [
            "That's awesome. What happened today you want to remember?",
            "Love this. What's one thing you're proud of?",
            "So good. Who would you want to text about this?",
            "Happy for you. What's your favorite part of today?"
        ],
        .high: [
            "Soak it in. What's the best thing that happened today?",
            "That's amazing. If today was a movie scene, what would it look like?",
            "This rules. Who helped you feel this good?",
            "Enjoy this. What's one thing you want to say thank you for?"
        ]
    ]

    private static let lonely: [Intensity: [String]] = [
        .low: [
            "That's okay to feel. Who have you been thinking about lately?",
            "Totally valid. What would make you feel less alone right now?",
            "That's hard. Is there someone you miss talking to?",
            "I get it. What's one thing you wish someone would ask you?"
        ],
        .mid: [
            "That's a real feeling. When did you last feel really seen?",
            "Feeling alone is hard. Who do you wish was here right now?",
            "I hear you. What's a time you felt close to someone?",
            "This is heavy. What's one thing you'd want to share, but haven't?"
        ],
        .high: [
            "You're not alone in this. What's the hardest part of today?",
            "I'm sorry it feels this way. If you could call anyone, who would it be?",
            "That's really hard. What do you wish you could say out loud?",
            "Your feelings make sense. What's one small thing that could help tonight?"
        ]
    ]

    private static let anxious: [Intensity: [String]] = [
        .low: [
            "That makes sense. What's on your mind that won't go away?",
            "Worry is okay to feel. What are you worried about right now?",
            "Got it. Is it a small worry or a big one?",
            "You're not alone. What usually helps when you feel like this?"
        ],
        .mid: [
            "Anxiety is exhausting. What's the worst thing you keep thinking might happen?",
            "That's a lot. What part of this is actually yours to fix?",
            "I hear you. Where do you feel this in your body?",
            "Totally fair. Who could you talk to about this?"
        ],
        .high: [
            "That's a lot to carry. What's the loudest thought in your head?",
            "You're doing okay. If a friend felt this way, what would you tell them?",
            "Let's slow down. Name three things you can see right now.",
            "You'll get through this. What's one thing that would help tonight?"
        ]
    ]

    private static let overwhelmed: [Intensity: [String]] = [
        .low: [
            "That's a lot. What's taking up the most space in your head?",
            "No shame in that. What's one thing you can push to tomorrow?",
            "Deep breath. What's the smallest next step you can take?",
            "Fair. What are you trying to juggle right now?"
        ],
        .mid: [
            "You've got a lot on you. What would feel like a break right now?",
            "That's heavy. What have you said yes to that you want to say no to?",
            "You need space. If you had one free hour, what would you do?",
            "Something's gotta give. What's one thing you can drop today?"
        ],
        .high: [
            "You can't carry it all. What's one thing you can let go of tonight?",
            "Be gentle with you. What are you expecting of yourself that's too much?",
            "You don't have to do this alone. Who could you ask for help?",
            "You deserve a pause. If you could stop everything, what would you do first?"
        ]
    ]

    private static let sad: [Intensity: [String]] = [
        .low: [
            "That's okay to feel. What feels a little harder than usual today?",
            "Sad days happen. Is this about something, or just there?",
            "Be kind to you. What's one gentle thing you can do for yourself?",
            "Totally valid. What would help you feel a little better right now?"
        ],
        .mid: [
            "Your sadness makes sense. What's making you feel this way?",
            "I'm sorry. When did you last feel okay?",
            "That's heavy. What memory keeps coming up?",
            "You deserve care. What do you need right now — a hug, quiet, music?"
        ],
        .high: [
            "This is really hard. What are you most sad about right now?",
            "You matter. What's the kindest thing you could do for yourself today?",
            "Your feelings deserve space. If this sadness could talk, what would it say?",
            "You don't have to be alone in this. Who would you want to sit with you?"
        ]
    ]

    private static let drained: [Intensity: [String]] = [
        .low: [
            "Rest is okay. What's been wearing you out lately?",
            "Give yourself a break. What's one thing you can skip tonight?",
            "You've been working hard. When did you last really rest?",
            "Fair question. Is this your body or your brain that's tired?"
        ],
        .mid: [
            "You're running low. What's taking more from you than it gives back?",
            "You deserve rest. What would a real break look like tonight?",
            "Totally fair. What are you doing because you have to vs. want to?",
            "Refill time. What would help you feel refilled?"
        ],
        .high: [
            "You're beyond tired. What's the real reason you feel this way?",
            "You can rest. If you could cancel one thing guilt-free, what?",
            "You've been strong too long. What have you been pushing through?",
            "You deserve to stop. What would it feel like to pause for a day?"
        ]
    ]

    private static let angry: [Intensity: [String]] = [
        .low: [
            "Fair enough. What bugged you today?",
            "That's okay to feel. What do you wish was different right now?",
            "Valid. Is there something you wish you had said?",
            "Got it. Where do you feel this in your body?"
        ],
        .mid: [
            "Anger's trying to tell you something. What's actually bothering you underneath?",
            "This is a safe space. What would you say if nothing bad could happen after?",
            "Honest check. Is this really about today, or something older?",
            "Your feelings count. Who or what crossed a line for you?"
        ],
        .high: [
            "Your anger is real. What crossed the line, and who did it?",
            "This matters. What is this anger trying to protect?",
            "Let it out safely. If your anger could speak, what would it say?",
            "You're allowed to feel this. What's one safe way to let it out right now?"
        ]
    ]

    private static let data: [Emotion: [Intensity: [String]]] = [
        .happy: happy,
        .lonely: lonely,
        .anxious: anxious,
        .overwhelmed: overwhelmed,
        .sad: sad,
        .drained: drained,
        .angry: angry
    ]

    static func random(
        for emotion: Emotion,
        intensity: Intensity,
        excluding current: String? = nil
    ) -> String {
        let pool = data[emotion]?[intensity] ?? []
        let candidates = pool.filter { $0 != current }
        return candidates.randomElement() ?? pool.randomElement() ?? "What's on your mind right now?"
    }
}
