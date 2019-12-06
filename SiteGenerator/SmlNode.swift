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

let newLine: SmlNode  = .text("\n")
let tab: SmlNode  = .text("\t")

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

func h1(_ children: [SmlNode]) -> SmlNode {
    return node("h1", [], children)
}

func h3(_ children: [SmlNode]) -> SmlNode {
    return node("h3", [], children)
}

func h4(_ children: [SmlNode]) -> SmlNode {
    return node("h4", [], children)
}

func div(_ attribs: [SmlAttribute], _ children: [SmlNode]) -> SmlNode {
    return node("div", attribs, children)
}

func article(_ attribs: [SmlAttribute], _ children: [SmlNode]) -> SmlNode {
    return node("article", attribs, children)
}

let css_class = SmlAttributeKey<String>("class")

func div_postBody(_ children: [SmlNode]) -> SmlNode {
    return div([css_class => "postBody"], children)
}

func div_postDateline(_ children: [SmlNode]) -> SmlNode {
    return div([css_class => "postDateline"], children)
}

func div_postStyledDateline(_ children: [SmlNode]) -> SmlNode {
    return div([css_class => "postDateline", style => "text-align:center"], children)
}

func div_blogArchiveIndex(_ children: [SmlNode]) -> SmlNode {
    return div([css_class => "blogArchiveIndex"], children)
}

func article_post(_ children: [SmlNode]) -> SmlNode {
    return article([css_class => "post"], children)
}

func img(_ attribs: [SmlAttribute]) -> SmlNode {
    return node("img", attribs, nil)
}

func a(_ attribs: [SmlAttribute], _ children: [SmlNode]) -> SmlNode {
    return node("a", attribs, children)
}

func a(_ children: [SmlNode]) -> SmlNode {
    return a([], children)
}

func li(_ children: [SmlNode]) -> SmlNode {
    return node("li", [], children)
}

func ul(_ children: [SmlNode]) -> SmlNode {
    return node("ul", [], children)
}

func main(_ children: [SmlNode]) -> SmlNode {
    return node("main", children)
}


infix operator =>
func => <A> (key: SmlAttributeKey<A>, value: A) -> SmlAttribute {
    return .init(key.key, "\(value)")
}

let href = SmlAttributeKey<String>("href")
let src = SmlAttributeKey<String>("src")
let height = SmlAttributeKey<String>("height")
let width = SmlAttributeKey<String>("width")
let alt = SmlAttributeKey<String>("alt")
let style = SmlAttributeKey<String>("style")
let id = SmlAttributeKey<String>("id")


