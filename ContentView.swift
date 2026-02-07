import SwiftUI

struct ContentView: View {
    @StateObject var appVM = AppViewModel()
    @AppStorage("darkMode") private var darkMode = false

    var body: some View {
        TabView {
            HomeView(statsVM: appVM.statsVM)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ItemsView(
                itemVM: appVM.itemVM,
                statsVM: appVM.statsVM
            )
            .tabItem {
                Label("Items", systemImage: "list.bullet")
            }

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
        .preferredColorScheme(darkMode ? .dark : .light)
        .onAppear {
            appVM.setup()
        }
    }
}
