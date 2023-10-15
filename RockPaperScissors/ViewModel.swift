import Foundation

protocol ViewModelDelegate: AnyObject {
    func getUsersNum() -> Int
    func getUsers() -> [UserSingle]
    func addUser(name: String, score: Int)
    func deleteUser(id: String)
    func saveUsers()
}

class ViewModel: ViewModelDelegate {

    var fileName: String
    var users: [UserSingle] = []

    let options = ["🪨", "📄", "✂️"]
    var cards: [CardItem] = []
    var userSelection = "?"
    var aiSelection = "?"
    var gameRezult = "Choose a card"
    var score = 0
    var attempts = 0
    var gameEnded = false

    init(fileName: String = "TodoCache",
         users: [UserSingle] = []) {
        self.fileName = fileName
        self.users = users
    }

    // MARK: GET
    func getUsersNum() -> Int {
        return users.count
    }

    func getUsers() -> [UserSingle] {
        do {
            try self.loadUsersJSON()
        } catch {
            print(error.localizedDescription)
        }
        return users
    }
    
    // MARK: SET
    func addUser(name: String, score: Int) {
        self.users.append(UserSingle(name: name, score: score))
    }

    func deleteUser(id: String) {
        if let index = users.firstIndex(where: {$0.id == id}) {
            self.users.remove(at: index)
        }
    }

    func saveUsers() {
        do {
            try self.saveUsersJSON()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: SaveJSON
    func saveUsersJSON() throws {
        do {
            guard
                let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            else { throw FileErrors.pathError}
            let fileURL = path.appendingPathComponent("\(self.fileName).json")

            let encoder = JSONEncoder()
            try encoder.encode(users).write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: LoadJSON
    func loadUsersJSON() throws {
        do {
            guard
                let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            else { throw FileErrors.pathError}
            let fileURL = path.appendingPathComponent("\(self.fileName).json")

            let textData = try String(contentsOf: fileURL, encoding: .utf8)
            guard
                let jsonData = textData.data(using: .utf8)
            else { throw FileErrors.loadError }

            let decoder = JSONDecoder()
            self.users = try decoder.decode([UserSingle].self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: GAME
    func makeCards(){
        cards.removeAll()
        for _ in 0..<5 {
            cards.append(CardItem(text: options.randomElement() ?? ""))
        }
    }

    func playGame(cardIndex: Int) {
        if attempts == 5 {
            gameEnded = true
        }
        userSelection = cards[cardIndex].text
        aiSelection = options.randomElement() ?? ""
        attempts += 1
        if userSelection == aiSelection {
            gameRezult = "Tie!"
        } else if (userSelection == "🪨" && aiSelection == "✂️") ||
                    (userSelection == "📄" && aiSelection == "🪨") ||
                    (userSelection == "✂️" && aiSelection == "📄") {
            gameRezult = "You win!"
            score += 1
        } else {
            gameRezult = "You lost!"
        }
    }

    func reset() {
        self.userSelection = "?"
        self.aiSelection = "?"
        self.gameRezult = "Choose a card"
        self.score = 0
        self.attempts = 0
        self.gameEnded = false
        self.makeCards()
    }
}
