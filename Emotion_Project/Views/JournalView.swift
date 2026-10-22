import SwiftUI
import PhotosUI

struct JournalView: View {
    @State var viewModel: JournalViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerRow
                Divider()

                if viewModel.isPromptVisible {
                    PromptCardView(
                        prompt: viewModel.prompt,
                        tint: viewModel.emotion.color,
                        onRefresh: { viewModel.refreshPrompt() },
                        onHide: { viewModel.togglePrompt() }
                    )
                } else {
                    Button {
                        viewModel.togglePrompt()
                    } label: {
                        Label("Show the Prompt", systemImage: "chevron.down")
                    }
                }

                titleField
                bodyEditor

                if !viewModel.images.isEmpty {
                    thumbnails
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 100)
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $viewModel.showCalendar) {
            CalendarView(viewModel: CalendarViewModel(store: viewModel.store))
        }
        .safeAreaInset(edge: .top) {
            customNavBar
                .background(.background)
        }
        .safeAreaInset(edge: .bottom) {
            bottomToolbar
        }
        .onChange(of: viewModel.pickerItems) { _, newItems in
            Task {
                await viewModel.loadImages(from: newItems)
            }
        }
    }

    private var headerRow: some View {
        HStack(spacing: 12) {
            Image(viewModel.emotion.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 2) {
                Text("\(viewModel.emotion.title) · \(viewModel.intensity.title)")
                    .font(.title3.bold())
                Text("Today · 9:41 AM")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }

    private var titleField: some View {
        TextField("Title (optional)", text: $viewModel.titleText)
            .font(.title2.bold())
            .textFieldStyle(.plain)
    }

    private var bodyEditor: some View {
        ZStack(alignment: .topLeading) {
            if viewModel.entryText.isEmpty {
                Text("Start anywhere. A few words are enough.")
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
                    .padding(.leading, 4)
            }
            TextEditor(text: $viewModel.entryText)
                .scrollContentBackground(.hidden)
                .frame(minHeight: 180)
        }
    }

    private var thumbnails: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.images.indices, id: \.self) { i in
                    Image(uiImage: viewModel.images[i])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }

    private var bottomToolbar: some View {
        HStack {
            Spacer()
            PhotosPicker(
                selection: $viewModel.pickerItems,
                maxSelectionCount: 5,
                matching: .images
            ) {
                Image(systemName: "camera")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(Capsule().fill(Color.gray.opacity(0.15)))
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }

    private var customNavBar: some View {
        HStack {
            BackButton
            Spacer()
            DoneButton
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    private var BackButton: some View {
        Button {
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
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
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
