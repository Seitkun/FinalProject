import Foundation

struct Item: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var date: Date
    var deadline: Date
    var type: ItemType
    var isDone: Bool
}
