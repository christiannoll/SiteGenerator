import Foundation

class Page {
    
    public func render() -> String {
        var htmlChildren: [SmlNode] = []
        htmlChildren.append(newLine)
        
        htmlChildren.append(renderHead())
        htmlChildren.append(newLine)
        
        htmlChildren.append(renderBody())
        htmlChildren.append(newLine)
        
        htmlChildren.append(renderFooter())
        
        let root = html(htmlChildren)
        return root.render()
    }
    
    private func renderBody() -> SmlNode {
        var bodyChildren: [SmlNode] = [newLine]
        
        bodyChildren.append(renderHeader())
        bodyChildren.append(newLine)
        
        bodyChildren.append(renderContent())
        bodyChildren.append(newLine)
        
        bodyChildren.append(renderFooter())
        
        let b = body(bodyChildren)
        return b
    }
    
    private func renderHead() -> SmlNode {
        var headChildren: [SmlNode] = [newLine, tab]
        
        headChildren.append(node("title", [.text("v.n.z.n")]))
        headChildren.append(newLine)
        
        let h = head(headChildren)
        return h
    }
    
    func renderContent() -> SmlNode {
        return .text("")
    }
    
    private func renderHeader() -> SmlNode {
        var headerChildren: [SmlNode] = [newLine, tab]
        
        let urlTitle: SmlNode = .text("v.n.z.n")
        let link = a([href => SmlBuilder.baseUrl], [urlTitle])
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
    
    private func renderFooter() -> SmlNode {
        return .text("")
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
    
    private func header(_ children: [SmlNode]) -> SmlNode {
        return node("header", children)
    }
    
    func span(_ attribs: [SmlAttribute], _ children: [SmlNode]) -> SmlNode {
        return node("span", attribs, children)
    }
}
