import Foundation

final class ItemViewModel: ObservableObject {
    @Published var items: [Item] = []

    func addItem(_ item: Item) {
        items.append(item)
        save()
    }

    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func updateItem(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
            save()
        }
    }
    func toggleDone(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isDone.toggle()
            save()
        }
    }


    func filteredItems(by type: ItemType) -> [Item] {
        items.filter { $0.type == type }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: "items")
        }
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: "items"),
           let saved = try? JSONDecoder().decode([Item].self, from: data) {
            items = saved
        }
    }
}
