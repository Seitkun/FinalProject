import Foundation

final class AppViewModel: ObservableObject {
    @Published var itemVM = ItemViewModel()
    @Published var statsVM = PlayerStatsViewModel()

    func setup() {
        itemVM.load()
        statsVM.load()
    }
}
