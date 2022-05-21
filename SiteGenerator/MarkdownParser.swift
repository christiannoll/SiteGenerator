import Foundation

public class MarkdownParser {
    
    public static func parse(text: String) -> [MarkdownNode] {
        let parser = MarkdownParser(text: text)
        let parsedNodes = parser.parseLinks(elements: parser.parse())
        return parser.parseLists(elements: parsedNodes)
    }
    
    private var tokenizer: MarkdownTokenizer
    private var openingDelimiters: [UnicodeScalar] = []
    private var olistElement: [MarkdownNode] = []
    private var ulistElement: [MarkdownNode] = []
    
    private init(text: String) {
        tokenizer = MarkdownTokenizer(string: text)
    }
    
    private func parse() -> [MarkdownNode] {
        var elements: [MarkdownNode] = []
        
        while let token = tokenizer.nextToken() {
            switch token {
            case .end:
                fallthrough
            case .tab:
                if olistElement.count > 0 {
                    let le: MarkdownNode = .olistelement(elements)
                    olistElement = []
                    return [le]
                }
                else if ulistElement.count > 0 {
                    let le: MarkdownNode = .ulistelement(elements)
                    ulistElement = []
                    return [le]
                }
                else if token == .tab {
                    elements.append(.linebreak)
                }
            case .newline:
                elements.append(.newline)
            case .text(let text):
                elements.append(.text(text))
            case .olistDelimiter(let delimiter):
                olistElement.append(.text(String(delimiter)))
                elements.append(contentsOf: parse())
            case .ulistDelimiter(let delimiter):
                ulistElement.append(.text(String(delimiter)))
                elements.append(contentsOf: parse())
                
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
            
            if token == .end {
                break
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
        
        for element in elements {
            switch element {
            case .brackets:
                if bracketsNode != nil {
                    nodes.append(bracketsNode!)
                }
                bracketsNode = element
            case .parenthesis(let parenthesisElements):
                if bracketsNode != nil {
                    let newElements: [MarkdownNode] = [element, bracketsNode!]
                    nodes.append(MarkdownNode(delimiter: " ", children: newElements)!)
                }
                else {
                    nodes.append(.parenthesis(parseLinks(elements: parenthesisElements)))
                }
                bracketsNode = nil
            case .ulistelement(let listElements):
                nodes.append(.ulistelement(parseLinks(elements: listElements)))
            case .olistelement(let listElements):
                nodes.append(.olistelement(parseLinks(elements: listElements)))
            case .code(let codeElements):
                nodes.append(.code(parseLinks(elements: codeElements)))
            default:
                if bracketsNode != nil {
                    nodes.append(bracketsNode!)
                }
                nodes.append(element)
                bracketsNode = nil
            }
        }
        
        if bracketsNode != nil {
            nodes.append(bracketsNode!)
        }
        
        return nodes
    }
    
    private func parseLists(elements: [MarkdownNode]) -> [MarkdownNode] {
        var nodes: [MarkdownNode] = []
        var oList: [MarkdownNode] = []
        var uList: [MarkdownNode] = []
        
        for element in elements {
            switch element {
            case .olistelement:
                oList.append(element)
            case .ulistelement:
                uList.append(element)
            case .text(let s) where s == " " && (oList.count > 0 || uList.count > 0):
                break
            case .linebreak:
                if oList.count == 0 && uList.count == 0 {
                    nodes.append(element)
                }
            default:
                if oList.count > 0 {
                    nodes.append(.olist(oList))
                    oList.removeAll()
                }
                else if uList.count > 0 {
                    nodes.append(.ulist(uList))
                    uList.removeAll()
                }
                nodes.append(element)
            }
        }
        
        if oList.count > 0 {
            nodes.append(.olist(oList))
        }
        else if uList.count > 0 {
            nodes.append(.ulist(uList))
        }
        return nodes
    }
}
