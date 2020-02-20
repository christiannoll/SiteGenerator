import Foundation

public enum MarkdownNode {
    case linebreak
    case text(String)
    case olistelement([MarkdownNode])
    case ulistelement([MarkdownNode])
    case bold([MarkdownNode])
    case italic([MarkdownNode])
    case code([MarkdownNode])
    case color(String, [MarkdownNode])
    case parenthesis([MarkdownNode])
    case brackets([MarkdownNode])
    case link([MarkdownNode])
    case ulist([MarkdownNode])
    case olist([MarkdownNode])
}

extension MarkdownNode: Equatable {}

extension MarkdownNode {
    init?(delimiter: UnicodeScalar, children: [MarkdownNode]) {
        switch delimiter {
        case "*":
            self = .bold(children)
        case "_":
            self = .italic(children)
        case "`":
            self = .code(children)
        case ")":
            self = .parenthesis(children)
        case "]":
            self = .brackets(children)
        case " ":
            self = .link(children)
        default:
            return nil
        }
    }
}
