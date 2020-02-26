import Foundation

class RssFeed {
    
    private var posts: [Item]
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    func render() -> String {
        return renderContent().render()
    }
    
    private func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        for post in posts {
            mainChildren.append(post.renderPost())
            if mainChildren.count > HomePage.max_number_of_posts {
                break
            }
        }
        
        return main(mainChildren)
    }
    
}
