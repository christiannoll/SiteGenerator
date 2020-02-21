import Foundation

class HomePage : Page {
    
    private var posts: [Item]
    private let max_number_of_posts = 32
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        for post in posts {
            mainChildren.append(post.renderPost())
            if mainChildren.count > max_number_of_posts {
                break
            }
        }
        
        mainChildren.append(newLine)
        mainChildren.append(renderArchiveLink())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
