import Foundation

class PostPage : Page {
    
    private let post: Item
    
    init(_ post: Item) {
        self.post = post
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        
        mainChildren.append(post.renderPost())
        
        mainChildren.append(newLine)
        mainChildren.append(renderArchiveLink())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    private func main(_ children: [SmlNode]) -> SmlNode {
        return node("main", children)
    }
}
