import Foundation

public enum MarkdownNode {
    case text(String)
    case bold([MarkdownNode])
    case italic([MarkdownNode])
    case parenthesis([MarkdownNode])
    case brackets([MarkdownNode])
    case link([MarkdownNode])
}

extension MarkdownNode: Equatable {}

extension MarkdownNode {
    init?(delimiter: UnicodeScalar, children: [MarkdownNode]) {
        switch delimiter {
        case "*":
            self = .bold(children)
        case "_":
            self = .italic(children)
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
