import Foundation

// MARK: FileErrors
enum FileErrors: Error {
    case saveError
    case loadError
    case pathError
}

// MARK: CardItem
struct CardItem{
    let id: String
    var text: String
    var active: Bool

    init(id: String = UUID().uuidString,
         text: String,
         active: Bool = true) {
        self.id = id
        self.text = text
        self.active = active
    }
}

// MARK: UserSingle
struct UserSingle: Identifiable, Codable{
    let id: String
    let name: String
    let score: Int

    init(id: String = UUID().uuidString,
         name: String,
         score: Int) {
        self.id = id
        self.name = name
        self.score = score
    }
}
