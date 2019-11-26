import Foundation

struct SmlAttribute {
    let key: String
    let value: String
    
    init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }
}

struct SmlAttributeKey<A> {
    let key: String
    init(_ key: String) { self.key = key }
}

struct SmlElement {
    let name: String
    let attribs: [SmlAttribute]
    let children: [SmlNode]?
    
    init(_ name: String, _ attribs: [SmlAttribute], _ children: [SmlNode]?) {
        self.name = name
        self.attribs = attribs
        self.children = children
    }
}

enum SmlNode {
    case element(SmlElement)
    case text(String)
}

extension SmlNode: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self = .text(value)
    }
}

extension SmlNode {
    func render() -> String {
        return SmlPrinter.render(node: self)
    }
}

func node(_ name: String, _ attribs: [SmlAttribute], _ children: [SmlNode]?) -> SmlNode {
    return .element(.init(name, attribs, children))
}

func node(_ name: String, _ children: [SmlNode]?) -> SmlNode {
    return node(name, [], children)
}

func p(_ attribs: [SmlAttribute], _ children: [SmlNode]) -> SmlNode {
    return node("p", attribs, children)
}

func p(_ children: [SmlNode]) -> SmlNode {
    return p([], children)
}

func a(_ attribs: [SmlAttribute], _ children: [SmlNode]) -> SmlNode {
    return node("a", attribs, children)
}

func a(_ children: [SmlNode]) -> SmlNode {
    return a([], children)
}

infix operator =>
func => <A> (key: SmlAttributeKey<A>, value: A) -> SmlAttribute {
    return .init(key.key, "\(value)")
}

let href = SmlAttributeKey<String>("href")

let document: SmlNode =
    p([
        "Welcome to you, who has come here. See ",
        a([href => "/more"], ["more"]),
        "."
        ])

