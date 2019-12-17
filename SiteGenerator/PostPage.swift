import Foundation

class PostPage : Page {
    
    private let post: Item
    
    init(_ post: Item) {
        self.post = post
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        
        mainChildren.append(post.renderPostInSingleMode())
        
        mainChildren.append(newLine)
        mainChildren.append(renderArchiveLink())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
