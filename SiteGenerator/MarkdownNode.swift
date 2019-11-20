import Foundation

public enum MarkdownNode {
    case text(String)
    case parenthesis([MarkdownNode])
    case brackets([MarkdownNode])
}

extension MarkdownNode: Equatable {}

extension MarkdownNode {
    init?(delimiter: UnicodeScalar, children: [MarkdownNode]) {
        switch delimiter {
        case ")":
            self = .parenthesis(children)
        case "]":
            self = .brackets(children)
        default:
            return nil
        }
    }
}
