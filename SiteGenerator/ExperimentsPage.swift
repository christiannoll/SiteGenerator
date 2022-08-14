import Foundation

class ExperimentsPage: BetaPage {
    
    override var title: String {
        get { experimentsTitle + " 🔬" }
    }
    
    override func setTitle() {
        setTitle(experimentsTitle)
    }
    
    override func getListItems() -> [SmlNode] {
        var ulChildren: [SmlNode] = []
        
        ulChildren.append(renderItem(advancedSearchTitle, "search"))
        ulChildren.append(newLine)
        
        return ulChildren
    }
    
    override func renderItem(_ title: String, _ relPath: String) -> SmlNode {
        var liChildren: [SmlNode] = []
        let link = a([href => (Page.baseUrl + relPath + "/advancedSearch.html")], [.text(title)])
        liChildren.append(link)
        let l = li(liChildren)
        return l
    }
}
