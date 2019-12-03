import Foundation

class Page {
    
    public static let baseUrl = "http://localhost:8000/"
    
    public func render() -> String {
        var htmlChildren: [SmlNode] = []
        htmlChildren.append(newLine)
        
        htmlChildren.append(renderHead())
        htmlChildren.append(newLine)
        
        htmlChildren.append(renderBody())
        htmlChildren.append(newLine)
        
        htmlChildren.append(renderNav())
        htmlChildren.append(newLine)
        
        htmlChildren.append(renderFooter())
        htmlChildren.append(newLine)
        
        let root = html(htmlChildren)
        return root.render()
    }
    
    private func renderBody() -> SmlNode {
        var bodyChildren: [SmlNode] = [newLine]
        
        bodyChildren.append(renderHeader())
        bodyChildren.append(newLine)
        
        bodyChildren.append(renderContent())
        bodyChildren.append(newLine)
        
        let b = body(bodyChildren)
        return b
    }
    
    private func renderHead() -> SmlNode {
        var headChildren: [SmlNode] = [newLine, tab]
        
        headChildren.append(node("title", [.text("v.n.z.n")]))
        headChildren.append(newLine)
        headChildren.append(tab)
        
        let metaViewPort = meta([name => "viewport", content => "width=device-width"])
        headChildren.append(metaViewPort)
        headChildren.append(newLine)
        headChildren.append(tab)
        
        let metaContent = meta([http_equiv => "Content-Type", content => "text/html; charset=utf-8"])
        headChildren.append(metaContent)
        headChildren.append(newLine)
        headChildren.append(tab)
        
        let l = link([rel => "stylesheet", type => "text/css", href => (Page.baseUrl + "styles.css")])
        headChildren.append(l)
        headChildren.append(newLine)
        
        let h = head(headChildren)
        return h
    }
    
    func renderContent() -> SmlNode {
        return .text("")
    }
    
    func renderArchiveLink() -> SmlNode {
        let link = a([href => (Page.baseUrl + "archive")], ["Archiv"])
        let para = p([link])
        return para
    }
    
    private func renderHeader() -> SmlNode {
        var headerChildren: [SmlNode] = [newLine, tab]
        
        let urlTitle: SmlNode = .text("v.n.z.n")
        let link = a([href => Page.baseUrl], [urlTitle])
        let spanBigLink = span([id => "biglink"], [link])
        headerChildren.append(spanBigLink)
        headerChildren.append(newLine)
        headerChildren.append(tab)
        
        let title: SmlNode = .text("Memento Mori")
        let spanBigByLine = span([id => "bigbyline"], [title])
        headerChildren.append(spanBigByLine)
        headerChildren.append(newLine)
        
        let h = header(headerChildren)
        return h
    }
    
    private func renderNav() -> SmlNode {
        var navChildren: [SmlNode] = [newLine, tab]
        
        var pChildren: [SmlNode] = []
        let index = a([href => (Page.baseUrl + "index")], ["Index"])
        pChildren.append(index)
        pChildren.append(.text(" • "))
        pChildren.append(newLine)
        pChildren.append(tab)
        
        let tags = a([href => (Page.baseUrl + "tags")], ["Kategorien"])
        pChildren.append(tags)
        
        let para = p(pChildren)
        navChildren.append(para)
        navChildren.append(newLine)
        
        let n = nav(navChildren)
        return n
    }
    
    private func renderFooter() -> SmlNode {
        var footerChildren: [SmlNode] = [newLine, tab]
        
        var pChildren: [SmlNode] = []
        let tags = a([href => (Page.baseUrl + "impressum")], ["Impressum"])
        pChildren.append(tags)
        
        let para = p(pChildren)
        footerChildren.append(para)
        footerChildren.append(newLine)
        
        let f = footer(footerChildren)
        return f
    }
    
    private func html(_ children: [SmlNode]) -> SmlNode {
        return node("html", children)
    }
    
    private func head(_ children: [SmlNode]) -> SmlNode {
        return node("head", children)
    }

    private func body(_ children: [SmlNode]) -> SmlNode {
        return node("body", children)
    }
    
    private func nav(_ children: [SmlNode]) -> SmlNode {
        return node("nav", children)
    }
    
    private func footer(_ children: [SmlNode]) -> SmlNode {
        return node("footer", children)
    }
    
    private func header(_ children: [SmlNode]) -> SmlNode {
        return node("header", children)
    }
    
    func span(_ attribs: [SmlAttribute], _ children: [SmlNode]) -> SmlNode {
        return node("span", attribs, children)
    }
    
    func meta(_ attribs: [SmlAttribute]) -> SmlNode {
        return node("meta", attribs, nil)
    }
    
    func link(_ attribs: [SmlAttribute]) -> SmlNode {
        return node("link", attribs, nil)
    }
    
    let content = SmlAttributeKey<String>("content")
    let name = SmlAttributeKey<String>("name")
    let http_equiv = SmlAttributeKey<String>("http-equiv")
    let rel = SmlAttributeKey<String>("rel")
    let type = SmlAttributeKey<String>("type")
}
