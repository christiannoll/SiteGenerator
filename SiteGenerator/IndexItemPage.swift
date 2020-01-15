import Foundation

class IndexItemPage : Page {
    
    private let indexItem: IndexItem
    
    init(_ indexItem: IndexItem) {
        self.indexItem = indexItem
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine, newLine]
        let key = indexItem.key
        let h_1 = h1([.text(key)])
        mainChildren.append(h_1)
        
        let posts = indexItem.renderIndexItemPosts()
        for post in posts {
            mainChildren.append(post)
        }
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
