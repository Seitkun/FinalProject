import Foundation

final class PlayerStatsViewModel: ObservableObject {
    @Published var stats = PlayerStats()

    func xpForNextLevel() -> Int {
        100 + (stats.level - 1) * 50
    }

    func addXP(for itemType: ItemType) {
        switch itemType {
        case .task:
            stats.productivity += 1
            stats.experience += 20
        case .note:
            stats.knowledge += 1
            stats.experience += 5
        }
        checkLevelUp()
        save()
    }


    private func checkLevelUp() {
        while stats.experience >= xpForNextLevel() {
            stats.experience -= xpForNextLevel()
            stats.level += 1
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(stats) {
            UserDefaults.standard.set(data, forKey: "player_stats")
        }
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: "player_stats"),
           let saved = try? JSONDecoder().decode(PlayerStats.self, from: data) {
            stats = saved
        }
    }
}
