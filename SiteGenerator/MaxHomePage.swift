import Foundation

class MaxHomePage : Page {
    
    private var posts: [Item]
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        for post in posts {
            mainChildren.append(post.renderPost())
            mainChildren.append(newLine)
        }
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
