import Foundation

class HomePage : Page {
    
    private var posts: [Item]
    static let max_number_of_posts = 32
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        var index = 1
        for post in posts {
            mainChildren.append(post.renderPost())
            mainChildren.append(newLine)
            if index >= HomePage.max_number_of_posts {
                break
            }
            index += 1
        }
        
        mainChildren.append(newLine)
        mainChildren.append(renderArchiveLink())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
