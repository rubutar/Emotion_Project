import SwiftUI

struct CalendarView: View {
    @State var viewModel: CalendarViewModel
    var onAddEntry: (() -> Void)? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                titleHeader

                DatePicker(
                    "Date",
                    selection: $viewModel.selectedDate,
                    in: ...Date(),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding(.horizontal)

                Text(selectedDateHeading)
                    .font(.headline)
                    .padding(.horizontal)

                if viewModel.entriesForSelectedDate.isEmpty {
                    Text("No entries for this date")
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                        .padding(.top, 8)
                } else {
                    VStack(spacing: 12) {
                        ForEach(viewModel.entriesForSelectedDate) { entry in
                            entryCard(entry)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var titleHeader: some View {
        HStack(spacing: 0) {
            Text("Your ")
                .font(.largeTitle.bold())
            Text("days.")
                .font(.largeTitle.bold())
                .underline(true, color: .yellow)
        }
        .padding(.horizontal)
    }

    private var selectedDateHeading: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter.string(from: viewModel.selectedDate)
    }

    private func entryCard(_ entry: JournalEntry) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(entry.emotion.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text("\(timeString(entry.date)) · \(entry.emotion.title) · \(entry.intensity.title)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                if !entry.title.isEmpty {
                    Text(entry.title)
                        .font(.headline)
                } else if !entry.text.isEmpty {
                    Text(entry.text)
                        .font(.headline)
                        .lineLimit(2)
                }

                if !entry.text.isEmpty && !entry.title.isEmpty {
                    Text(entry.text)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
        )
    }

    private func timeString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationStack {
        CalendarView(viewModel: CalendarViewModel(store: JournalStore()))
    }
}
