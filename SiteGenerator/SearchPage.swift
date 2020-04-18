import Foundation

class SearchPage : Page {
    
    private let searchItems: SearchItems
    
    init(_ searchItems: SearchItems) {
        self.searchItems = searchItems
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(searchItems.renderSearchItems())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
