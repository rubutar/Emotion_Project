import SwiftUI

struct MainTabView: View {
    @Environment(JournalStore.self) private var store
    @State private var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            EmotionTranslatorView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            NavigationStack {
                CalendarView(
                    viewModel: CalendarViewModel(store: store),
                    onAddEntry: { selection = 0 }
                )
            }
            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }
            .tag(1)
        }
    }
}

#Preview {
    MainTabView()
        .environment(JournalStore())
}
