import SwiftUI
import PhotosUI

struct JournalView: View {
    @State var viewModel: JournalViewModel
    @Environment(\.dismiss) private var dismiss
    


    var body: some View {
        ScrollView{
            HStack(spacing: 12) {
                Spacer()
                Image("\(viewModel.emotion.imageName)")
                Spacer()
                VStack(alignment: .leading) {
                    Text("\(viewModel.emotion.title) · \(viewModel.intensity.title)").font(.headline)
                    Text("Today · 3:30 PM").font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
            }
            VStack(spacing: 24) {

                if viewModel.isPromptVisible {
                    PromptCardView(prompt: viewModel.prompt, tint: viewModel.emotion.color, onRefresh: { viewModel.refreshPrompt()},
                        onHide: {
                        viewModel.togglePrompt()
                    }
                    )
                } else {
                    Button {
                        viewModel.togglePrompt()
                    } label: {
                        Label("Show the Prompt", systemImage: "chevron.down")
                    }
                }


                TextEditor(text: $viewModel.entryText)
                    .frame(minHeight: 140)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3))
                    )
//                if !viewModel.images.isEmpty {
//                    ScrollView(.horizontal) {
//                        HStack {
//                            ForEach(viewModel.images.indices, id: \.self) { i in
//                                Image(uiImage: viewModel.images[i])
//                                    .re
//                            
//                        }
//                    }
//                }

                
                
                Spacer()
                PhotosPicker(selection: $viewModel.pickerItems, maxSelectionCount: 5, matching: .images) {
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
