import Foundation

enum MarkdownToken {
    case tab
    case text(String)
    case leftDelimiter(UnicodeScalar)
    case rightDelimiter(UnicodeScalar)
}

extension MarkdownToken: Equatable {}

extension MarkdownToken: CustomStringConvertible {
    var description: String {
        switch self {
        case .tab:
            return "\n"
        case .text(let value):
            return value
        case .leftDelimiter(let value):
            return String(value)
        case .rightDelimiter(let value):
            return String(value)
        }
    }
}


extension CharacterSet {
    static let delimiters = CharacterSet(charactersIn: "[]()*_")
    static let whitespaceAndPunctuation = CharacterSet.whitespacesAndNewlines
        .union(CharacterSet.punctuationCharacters)
    
    static func getLeftDelimiter(rightDelimiter: UnicodeScalar) -> UnicodeScalar {
        switch(rightDelimiter) {
        case ")":
            return "("
        case "]":
            return "["
        default:
            return " "
        }
    }
    
    static func isTab(_ c: UnicodeScalar) -> Bool {
        if c == UnicodeScalar.space {
            return false
        }
        
        return CharacterSet.whitespacesAndNewlines.contains(c)
    }
}

private extension UnicodeScalar {
    static let space: UnicodeScalar = " "
    static let tab: UnicodeScalar = "\t"
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
        
        if CharacterSet.delimiters.contains(c) {
            token = scan(delimiter: c)
        }
        else if c == UnicodeScalar.tab {
            token = .tab
            advance()
        } else {
            token = scanText()
        }
        
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
        guard index < input.endIndex else {
            return nil
        }  
        return input[index]
    }
    
    private func scan(delimiter d: UnicodeScalar) -> MarkdownToken? {
        return scanRight(delimiter: d) ?? scanLeft(delimiter: d)
    }
    
    private func scanLeft(delimiter: UnicodeScalar) -> MarkdownToken? {
        let p = previous ?? .space
        
        guard let n = next else {
            return nil
        }
        
        // Left delimiters must be predeced by whitespace or punctuation
        // and NOT followed by whitespaces or newlines
        guard CharacterSet.whitespaceAndPunctuation.contains(p) &&
            !CharacterSet.whitespacesAndNewlines.contains(n) &&
            !leftDelimiters.contains(delimiter) else {
                return nil
        }
        
        leftDelimiters.append(delimiter)
        advance()
        
        return .leftDelimiter(delimiter)
    }
    
    private func scanRight(delimiter: UnicodeScalar) -> MarkdownToken? {
        guard let p = previous else {
            return nil
        }
        
        let n = next ?? .space
        
        // Right delimiters must NOT be preceded by whitespace and must be
        // followed by whitespace or punctuation
        guard !CharacterSet.whitespacesAndNewlines.contains(p) &&
            CharacterSet.whitespaceAndPunctuation.contains(n) &&
            (leftDelimiters.contains(delimiter) || leftDelimiters.contains(CharacterSet.getLeftDelimiter(rightDelimiter:delimiter))) else {
                return nil
        }
        
        while !leftDelimiters.isEmpty {
            if leftDelimiters.popLast() == delimiter {
                break
            }
        }
        advance()
        
        return .rightDelimiter(delimiter)
    }

    private func scanText() -> MarkdownToken? {
        let startIndex = currentIndex
        scanUntil { CharacterSet.delimiters.contains($0) || UnicodeScalar.tab == $0}
        
        guard currentIndex > startIndex else {
            return nil
        }
        
        return .text(String(input[startIndex ..< currentIndex]))
    }
    
    private func scanUntil(_ predicate: (UnicodeScalar) -> Bool) {
        while currentIndex < input.endIndex && !predicate(input[currentIndex]) {
            advance()
        }
    }
 
    private func advance() {
        currentIndex = input.index(after: currentIndex)
    }
}
