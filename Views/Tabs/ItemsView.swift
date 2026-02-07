import SwiftUI

struct ItemsView: View {
    @ObservedObject var itemVM: ItemViewModel
    @ObservedObject var statsVM: PlayerStatsViewModel

    @State private var selectedType: ItemType = .task
    @State private var showForm = false

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Type", selection: $selectedType) {
                    ForEach(ItemType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                List {
                    ForEach(itemVM.filteredItems(by: selectedType)) { item in
                        NavigationLink {
                            ItemDetailView(item: item)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .strikethrough(item.isDone)
                                        .foregroundColor(item.isDone ? .gray : .primary)

                                    Text("Deadline: \(item.deadline, style: .date)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)

                                }

                                Spacer()

                                Button {
                                    itemVM.toggleDone(item)
                                    if item.isDone == false {
                                        statsVM.addXP(for: .task)
                                    }
                                } label: {
                                    Image(systemName: item.isDone
                                          ? "checkmark.circle.fill"
                                          : "circle")
                                        .foregroundColor(item.isDone ? .green : .gray)
                                }
                                .buttonStyle(.plain)

                            }
                        }
                    }
                    .onDelete(perform: itemVM.deleteItem)
                }
            }
            .navigationTitle("Items")
            .toolbar {
                Button {
                    showForm = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showForm) {
                ItemFormView(itemVM: itemVM, statsVM: statsVM)
            }
        }
    }
}
