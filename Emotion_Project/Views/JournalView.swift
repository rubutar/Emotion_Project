import SwiftUI

struct JournalView: View {
    @State var viewModel: JournalViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView{
            HStack(spacing: 12) {
                Spacer()
                Image(systemName: "face.smiling")
                Spacer()
                VStack(alignment: .leading) {
                    Text("\(viewModel.emotion.title) · \(viewModel.intensity.title)").font(.headline)
                    Text("Today · 3:30 PM").font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
            }
            VStack(spacing: 24) {

                PromptCardView(prompt: viewModel.prompt)

                TextEditor(text: $viewModel.entryText)
                    .frame(minHeight: 140)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3))
                    )

                Spacer()
                Button{
                    
                }label: {
                    Label("", systemImage: "camera")
                }
            }
            .padding()
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $viewModel.showCalendar) {
                CalendarView(viewModel: CalendarViewModel(store: viewModel.store))
            }
        }
        .safeAreaInset(edge: .top) {
            customNavBar
                .background(.background)
        }
    }
    private var customNavBar: some View {
        HStack{
            BackButton
            Spacer()
            DoneButton
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    private var BackButton: some View {
        Button{
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.headline)
                .foregroundStyle(.black)
                .frame(width: 36, height: 36)
                .background(Circle().fill(Color.gray.opacity(0.15)))
        }
    }
    private var DoneButton: some View {
        Button("Done") {
            viewModel.submit()
        }
        .font(.subheadline.bold())
        .foregroundStyle(.white)
        .padding()
        .background(Capsule().fill(Color.black))
    }
}

#Preview {
    NavigationStack {
        JournalView(
            viewModel: JournalViewModel(
                emotion: .happy,
                intensity: .mid,
                store: JournalStore()
            )
        )
    }
}
