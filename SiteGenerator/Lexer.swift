import Foundation

enum Token {
    case eof
}

class Lexer {
    
    private let text: String
    private var currentPosition: Int
    private var currentCharacter: Character?
    
    public init(_ text: String) {
        self.text = text
        currentPosition = 0
        currentCharacter = text.isEmpty ? nil : text[text.startIndex]
    }
 
    private func advance() {
        currentPosition += 1
        guard currentPosition < text.count else {
            currentCharacter = nil
            return
        }
    }
}
