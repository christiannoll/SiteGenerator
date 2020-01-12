import Foundation

class HomePage : Page {
    
    private var posts: [Item]
    private let max_number_of_posts = 20
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    override func renderContent() -> SmlNode {
        sortCurrentFirst()
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
    
    private func sortCurrentFirst() {
        posts.sort { $0.date! > $1.date! }
    }
}
