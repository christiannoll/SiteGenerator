import Foundation

class SearchPage : Page {
    
    private let searchItems: SearchItems
    
    var searchCallString: String {
        get { "search(this.value)"  }
    }
    
    var searchTip: String {
        get { SiteGeneratorEnv.forGerman() ? "Suche ..." : "Search ..." }
    }
    
    init(_ searchItems: SearchItems) {
        self.searchItems = searchItems
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        
        mainChildren.append(input([type => "text", id => "search-bar", placeholder => searchTip, name => "search", onkeyup => searchCallString]))
        mainChildren.append(newLine)
        
        mainChildren.append(searchItems.renderSearchItems())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    override func createJavascriptInclude() -> SmlNode? {
        let javascript = script([src => "search.js", type => "text/javascript"])
        return javascript
    }
    
    override func body(_ children: [SmlNode]) -> SmlNode {
        let attributes = [onLoad => "startSearchWorker()"]
        return node("body", attributes, children)
    }
    
    func setTitle() {
        setTitle(searchTitle)
    }
}
