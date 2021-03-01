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

func element_node(_ name: String, _ content: String) -> SmlNode {
    return .element(.init(name, [], [.text(content)]))
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

func div_menuLine(_ children: [SmlNode]) -> SmlNode {
    return div([css_class => "menuLine"], children)
}

func article_post(_ children: [SmlNode]) -> SmlNode {
    return article([css_class => "post"], children)
}

func img(_ attribs: [SmlAttribute]) -> SmlNode {
    return node("img", attribs, nil)
}

func br() -> SmlNode {
    return node("br", [], nil)
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

func li(_ index: Int, _ children: [SmlNode]) -> SmlNode {
    return node("li", [id => String(index)], children)
}

func li_style(_ index: Int, _ children: [SmlNode]) -> SmlNode {
    return node("li", [id => String(index), style => "display:list-item;"], children)
}

func ul(_ children: [SmlNode]) -> SmlNode {
    return node("ul", [], children)
}

func main(_ children: [SmlNode]) -> SmlNode {
    return node("main", children)
}

func title_node(_ content: String) -> SmlNode {
    return element_node("title", content)
}

func link_node(_ content: String) -> SmlNode {
    return element_node("link", content)
}

func guid_node(_ content: String) -> SmlNode {
    return element_node("guid", content)
}

func pubDate_node(_ content: String) -> SmlNode {
    return element_node("pubDate", content)
}

func description_node(_ content: String) -> SmlNode {
    return element_node("description", content)
}

func language_node(_ content: String) -> SmlNode {
    return element_node("language", content)
}

func item_node(_ children: [SmlNode]) -> SmlNode {
    return node("item", children)
}

func channel_node(_ children: [SmlNode]) -> SmlNode {
    return node("channel", children)
}

func rss_node(_ children: [SmlNode]) -> SmlNode {
    return node("rss", [version => "2"], children)
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
let version = SmlAttributeKey<String>("version")
let title_attr = SmlAttributeKey<String>("title")
let placeholder = SmlAttributeKey<String>("placeholder")

