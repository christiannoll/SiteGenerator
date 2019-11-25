import Foundation

class SmlBuilder {
    
    public func parse(_ markdownNodes: [MarkdownNode]) -> String {
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
                s.append("\" link_url=\"")
                s.append(parse(nodes))
                s.append("\"")
            case .brackets(let nodes):
                s.append("link_title=\"")
                s.append(parse(nodes))
            default:
                break
            }
        }
        return s
    }
    
    
}