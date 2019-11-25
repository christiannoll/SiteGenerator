import Foundation

public class MarkdownParser {
    public static func parse(text: String) -> [MarkdownNode] {
        let parser = MarkdownParser(text: text)
        return parser.parseLinks(elements: parser.parse())
    }
    
    private var tokenizer: MarkdownTokenizer
    private var openingDelimiters: [UnicodeScalar] = []
    
    private init(text: String) {
        tokenizer = MarkdownTokenizer(string: text)
    }
    
    private func parse() -> [MarkdownNode] {
        var elements: [MarkdownNode] = []
        
        while let token = tokenizer.nextToken() {
            switch token {
            case .text(let text):
                elements.append(.text(text))
                
            case .leftDelimiter(let delimiter):
                // Recursively parse all the tokens following the delimiter
                openingDelimiters.append(delimiter)
                elements.append(contentsOf: parse())
                
            case .rightDelimiter(let delimiter) where (openingDelimiters.contains(delimiter) || openingDelimiters.contains(CharacterSet.getLeftDelimiter(rightDelimiter:delimiter))):
                guard let containerNode = close(delimiter: delimiter, elements: elements) else {
                    fatalError("There is no MarkupNode for \(delimiter)")
                }
                return [containerNode]
                
            default:
                elements.append(.text(token.description))
            }
        }
        
        // Convert orphaned opening delimiters to plain text
        let textElements: [MarkdownNode] = openingDelimiters.map { .text(String($0)) }
        elements.insert(contentsOf: textElements, at: 0)
        openingDelimiters.removeAll()
        
        return elements
    }
    
    private func close(delimiter: UnicodeScalar, elements: [MarkdownNode]) -> MarkdownNode? {
        var newElements = elements
        
        // Convert orphaned opening delimiters to plain text
        while openingDelimiters.count > 0 {
            let openingDelimiter = openingDelimiters.popLast()!
            
            if openingDelimiter == delimiter || openingDelimiter == CharacterSet.getLeftDelimiter(rightDelimiter:delimiter) {
                break
            } else {
                newElements.insert(.text(String(openingDelimiter)), at: 0)
            }
        }
        
        return MarkdownNode(delimiter: delimiter, children: newElements)
    }
    
    private func parseLinks(elements: [MarkdownNode]) -> [MarkdownNode] {
        var nodes: [MarkdownNode] = []
        
        var bracketsNode: MarkdownNode?
        
        for element: MarkdownNode in elements {
            switch element {
            case .text:
                if bracketsNode != nil {
                    nodes.append(bracketsNode!)
                }
                nodes.append(element)
                bracketsNode = nil
            case .brackets:
                if bracketsNode != nil {
                    nodes.append(bracketsNode!)
                }
                bracketsNode = element
            case .parenthesis:
                if bracketsNode != nil {
                    let newElements: [MarkdownNode] = [element, bracketsNode!]
                    nodes.append(MarkdownNode(delimiter: " ", children: newElements)!)
                }
                bracketsNode = nil
            default:
                break
            }
        }
        
        if bracketsNode != nil {
            nodes.append(bracketsNode!)
        }
        
        return nodes
    }
}
