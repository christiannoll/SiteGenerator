import Foundation

class SmlBuilder {
    
    public func parse(_ markdownNodes: [MarkdownNode]) -> SmlNode {
        let smlNode: SmlNode = .text(parse(markdownNodes))
        return p([smlNode])
    }
    
    private func parse(_ markdownNodes: [MarkdownNode]) -> String {
        var s = ""
        for markDownNode: MarkdownNode in markdownNodes {
            switch markDownNode {
            case .text(let text):
                s.append(text)
            case .parenthesis(let nodes):
                s.append("(")
                s.append(parse(nodes))
                s.append(")")
            case .brackets(let nodes):
                s.append("[")
                s.append(parse(nodes))
                s.append("]")
            case .link(let nodes):
                s.append(parseLink(nodes))
            }
        }
        return s
    }
    
    private func parseLink(_ markdownNodes: [MarkdownNode]) -> String {
        var s = ""
        for markDownNode: MarkdownNode in markdownNodes {
            switch markDownNode {
            case .text(let text):
                s.append(text)
            case .parenthesis(let nodes):
                s.append("<a href=\"")
                s.append(parse(nodes))
                s.append("\">")
            case .brackets(let nodes):
                s.append(parse(nodes))
                s.append("</a>")
            default:
                break
            }
        }
        return s
    }
    
    
}
