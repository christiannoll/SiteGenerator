import Foundation

public class SmlBuilder {
    
    public init() {}
    
    public static func buildUrl(_ urlString: String) -> String {
        if urlString.starts(with: "#") {
            return urlString.replaceFirst(of: "#", with: Page.baseUrl)
        }
        return urlString
    }
    
    public func render(_ text: String) -> String {
        let markdownNodes = MarkdownParser.parse(text: text)
        let smlNode: SmlNode  = parse(markdownNodes)
        return smlNode.render()
    }
    
    func parse(_ markdownNodes: [MarkdownNode]) -> SmlNode {
        let smlNode: SmlNode = .text(parse(markdownNodes))
        return smlNode
    }
    
    private func parse(_ markdownNodes: [MarkdownNode]) -> String {
        var s = ""
        for markDownNode in markdownNodes {
            switch markDownNode {
            case .linebreak:
                s.append("</p>\n\t\t<p>")
            case .newline:
                s.append("<br>")
            case .text(let text):
                s.append(text)
            case .bold(let nodes):
                s.append("<strong>")
                s.append(parse(nodes))
                s.append("</strong>")
            case .italic(let nodes):
                s.append("<em>")
                s.append(parse(nodes))
                s.append("</em>")
            case .code(let nodes):
                s.append("<code>")
                s.append(parseCode(nodes))
                s.append("</code>")
            case .color(let color, let nodes):
                s.append("<span style=\"color:" + color + "\">")
                s.append(parse(nodes))
                s.append("</span>")
            case .parenthesis(let nodes):
                s.append("(")
                s.append(parse(nodes))
                s.append(")")
            case .brackets(let nodes):
                s.append("[")
                s.append(parse(nodes))
                s.append("]")
            case .curlybraces(let nodes):
                s.append("<div style=\"text-align:center\">")
                s.append(parse(nodes))
                s.append("</div>")
            case .olistelement(let nodes):
                s.append("<li>")
                s.append(parse(nodes))
                s.append("</li>")
            case .ulistelement(let nodes):
                s.append("<li>")
                s.append(parse(nodes))
                s.append("</li>")
            case .link(let nodes):
                s.append(parseLink(nodes))
            case .ulist(let nodes):
                s.append("<ul>")
                s.append(parse(nodes))
                s.append("</ul>")
            case .olist(let nodes):
                s.append("<ol>")
                s.append(parse(nodes))
                s.append("</ol>")
            }
        }
        return s
    }
    
    private func parseLink(_ markdownNodes: [MarkdownNode]) -> String {
        var s = ""
        for markDownNode in markdownNodes {
            switch markDownNode {
            case .text(let text):
                s.append(text)
            case .parenthesis(let nodes):
                s.append("<a href=\"")
                s.append(SmlBuilder.buildUrl(parse(nodes)))
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
    
    private func parseCode(_ markdownNodes: [MarkdownNode]) -> String {
        var s = ""
        for markDownNode in markdownNodes {
            switch markDownNode {
            case .linebreak:
                s.append("<br>")
            case .text(let text):
                s.append(text)
            default:
                s.append(parse([markDownNode]))
            }
        }
        return s
    }
}

extension String {
    
    public func replaceFirst(of pattern: String, with replacement: String) -> String {
        if let range = self.range(of: pattern) {
            self.replacingCharacters(in: range, with: replacement)
        } else {
            self
        }
    }
}
