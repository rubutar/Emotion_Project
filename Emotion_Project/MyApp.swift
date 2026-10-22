import SwiftUI

@main struct MyApp: App {
    @State private var store = JournalStore()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(store)
        }
    }
}
