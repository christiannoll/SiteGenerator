import Foundation

class TagItemPage : Page {
    
    private let tagItem: TagItem
    
    init(_ tagItem: TagItem) {
        self.tagItem = tagItem
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine, newLine]
        let h_1 = h1([.text(tagItem.key)])
        mainChildren.append(h_1)
        
        let posts = tagItem.renderTagItemPosts()
        for post: SmlNode in posts {
            mainChildren.append(post)
        }
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
