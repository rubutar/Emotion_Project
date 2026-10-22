import SwiftUI

struct MainTabView: View {
    @Environment(JournalStore.self) private var store

    var body: some View {
        TabView {
            EmotionTranslatorView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            NavigationStack {
                CalendarView(viewModel: CalendarViewModel(store: store))
            }
            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }
        }
    }
}

#Preview {
    MainTabView()
        .environment(JournalStore())
}
