import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isAI: Bool
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id && lhs.text == rhs.text && lhs.isAI == rhs.isAI
    }
}
