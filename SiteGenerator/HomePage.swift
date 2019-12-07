import Foundation

class HomePage : Page {
    
    private let posts: [Item]
    private let max_number_of_posts = 10
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        for post: Item in posts {
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
