import Foundation

struct Emoji: Codable, Equatable {
    var name: String
    var category:String
    var description: String

    var sectionTitle: String {
        category
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
}

struct Section: Codable {
    var title: String
    var emojis: [Emoji]
}
