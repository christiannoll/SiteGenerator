import Foundation

enum MarkdownToken {
    case text(String)
    case leftDelimiter(UnicodeScalar)
    case rightDelimiter(UnicodeScalar)
}

private extension CharacterSet {
    static let delimiters = CharacterSet(charactersIn: "[]()")
    static let whitespaceAndPunctuation = CharacterSet.whitespacesAndNewlines
        .union(CharacterSet.punctuationCharacters)
}

private extension UnicodeScalar {
    static let space: UnicodeScalar = " "
}

class MarkdownTokenizer {
    
    private let input: String.UnicodeScalarView
    private var currentIndex: String.UnicodeScalarView.Index
    private var leftDelimiters: [UnicodeScalar] = []
    
    public init(string: String) {
        input = string.unicodeScalars
        currentIndex = string.unicodeScalars.startIndex
    }
    
    func nextToken() -> MarkdownToken? {
        guard let c = current else {
            return nil
        }
        
        var token: MarkdownToken?
        
        if token == nil {
            token = .text(String(c))
            advance()
        }
        
        return token
    }
    
    private var current: UnicodeScalar? {
        guard currentIndex < input.endIndex else {
            return nil
        }
        return input[currentIndex]
    }
    
    private var previous: UnicodeScalar? {
        guard currentIndex > input.startIndex else {
            return nil
        }
        let index = input.index(before: currentIndex)
        return input[index]
    }
    
    private var next: UnicodeScalar? {
        guard currentIndex < input.endIndex else {
            return nil
        }
        let index = input.index(after: currentIndex)
        return input[index]
    }
 
    private func advance() {
        currentIndex = input.index(after: currentIndex)
    }
}
