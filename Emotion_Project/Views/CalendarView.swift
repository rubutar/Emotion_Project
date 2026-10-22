import SwiftUI

struct CalendarView: View {
    @State var viewModel: CalendarViewModel

    var body: some View {
        VStack(spacing: 16) {
            DatePicker(
                "Date",
                selection: $viewModel.selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding(.horizontal)

            if viewModel.entriesForSelectedDate.isEmpty {
                Text("No entries for this date")
                    .foregroundStyle(.secondary)
                    .padding(.top, 24)
                Spacer()
            } else {
                List(viewModel.entriesForSelectedDate) { entry in
                    VStack(alignment: .leading, spacing: 4) {
                        Image(entry.emotion.imageName)
                        Text(entry.emotion.title)
                            .font(.headline)
                        Text("Intensity: \(entry.intensity.title)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CalendarView(viewModel: CalendarViewModel(store: JournalStore()))
    }
}
