import SwiftUI

struct ItemDetailView: View {
    let item: Item

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(item.title)
                .font(.largeTitle)
                .bold()

            Text(item.description)

            Text("Date: \(item.date.formatted())")
            Text("Type: \(item.type.rawValue)")


            Spacer()
        }
        .padding()
    }
}
