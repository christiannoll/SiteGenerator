import Foundation

struct SmlPrinter {

    static func render(node: SmlNode) -> String {
        switch node {
        case let .element(e):
            return render(element:  e)
        case let .text(t):
            return t
        }
    }
    
    static func render(attributes: [SmlAttribute]) -> String {
        return attributes.map {attr in "\(attr.key)=\"\(attr.value)\"" } . joined(separator: " ")
    }
    
    static func render(element: SmlElement) -> String {
        let openTag = "<\(element.name)"
        let openTagWithAttrs = openTag
            + (element.attribs.isEmpty ? "" : " ")
            + render(attributes: element.attribs)
            + (element.children != nil ? ">" : "")
        let children = (element.children ?? []).map(render(node:)).joined()
        let closeTag = element.children == nil ? "/>" : "</\(element.name)>"
        
        return openTagWithAttrs + children + closeTag
    }
}
