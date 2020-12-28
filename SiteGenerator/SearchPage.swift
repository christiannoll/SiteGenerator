import Foundation

class SearchPage : Page {
    
    private let searchItems: SearchItems
    
    init(_ searchItems: SearchItems) {
        self.searchItems = searchItems
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        
        let searchTip = SiteGeneratorEnv.forGerman() ? "Suche ..." : "Search ..."
        mainChildren.append(input([type => "text", id => "search-bar", placeholder => searchTip, name => "search", onkeyup => "search(this.value)"]))
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
}
