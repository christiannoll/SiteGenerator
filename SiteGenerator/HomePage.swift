import Foundation

class HomePage : Page {
    
    enum SortOrder {
        case latestFirst
        case shuffled
    }
    
    private var posts: [Item]
    public static let max_number_of_posts = 32
    
    init(_ posts: [Item], sortOrder: SortOrder = .latestFirst) {
        self.posts = posts
        if sortOrder == .shuffled {
            self.posts.shuffle()
        }
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
