import Foundation

class TagItemPage : Page {
    
    private let tagItem: TagItem
    
    static let photoKey = SiteGeneratorEnv.forGerman() ? "Foto" : "Photo"
    
    init(_ tagItem: TagItem) {
        self.tagItem = tagItem
    }
    
    var key: String {
        get {
            let key = tagItem.key == Self.photoKey ? "" : tagItem.key
            return key
        }
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine, newLine]
        let h_1 = h1([.text(key)])
        mainChildren.append(h_1)
        
        let posts = tagItem.renderTagItemPosts()
        for post in posts {
            mainChildren.append(post)
        }
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
