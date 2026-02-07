import SwiftUI

struct ItemFormView: View {
    @ObservedObject var itemVM: ItemViewModel
    @ObservedObject var statsVM: PlayerStatsViewModel

    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var type: ItemType = .task
    @State private var isDone = false
    @State private var amount = ""
    @State private var deadline = Date()


    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)

                TextEditor(text: $description)
                    .frame(height: 100)

                DatePicker("Date", selection: $date)
                DatePicker("Deadline", selection: $deadline, displayedComponents: .date)


                Picker("Type", selection: $type) {
                    ForEach(ItemType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }

                Toggle("Completed", isOn: $isDone)

                
            }
            .navigationTitle("New Item")
            .toolbar {
                Button("Save") {
                    saveItem()
                }
            }
        }
    }

    private func saveItem() {
        let newItem = Item(
            id: UUID(),
            title: title,
            description: description,
            date: Date(),
            deadline: deadline,
            type: type,
            isDone: isDone
        )


        itemVM.addItem(newItem)
        statsVM.addXP(for: type)
        dismiss()
    }
}
