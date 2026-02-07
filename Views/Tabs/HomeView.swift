import SwiftUI

struct HomeView: View {
    @ObservedObject var statsVM: PlayerStatsViewModel

    var body: some View {
        VStack(spacing: 20) {

            Text("🏆 Level \(statsVM.stats.level)")
                .font(.largeTitle)
                .bold()

            ProgressView(
                value: Double(statsVM.stats.experience),
                total: Double(statsVM.xpForNextLevel())
            )
            .padding()
            .animation(.easeInOut, value: statsVM.stats.experience)

            Text("XP: \(statsVM.stats.experience) / \(statsVM.xpForNextLevel())")

            Divider()

            HStack {
                statView(title: "📋 Productivity", value: statsVM.stats.productivity)
                statView(title: "📚 Knowledge", value: statsVM.stats.knowledge)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            statsVM.load()
        }
    }

    private func statView(title: String, value: Int) -> some View {
        VStack {
            Text(title)
            Text("\(value)")
                .font(.title2)
                .bold()
        }
        .frame(maxWidth: .infinity)
    }
}
