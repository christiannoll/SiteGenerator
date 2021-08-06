import Foundation

class PostListItem {
    
    private let postBuilder = PostBuilder()
    private var posts: [Item] = []
    
    func addPost(_ post: Item) {
        if !containsPost(post) {
            posts.append(post)
        }
    }
    
    func renderPostListItem() -> SmlNode {
        if posts.count > 0 {
            var ulChildren: [SmlNode] = []
            
            for post in posts {
                ulChildren.append(renderItem(post))
                ulChildren.append(newLine)
            }
            
            let u = ul(ulChildren)
            return u
        }
        else {
            return .text("")
        }
    }
    
    private func renderItem(_ post: Item) -> SmlNode {
        var liChildren: [SmlNode] = []
        let link = postBuilder.createPostLink(post)
        liChildren.append(link)
        let l = li(liChildren)
        return l
    }
    
    private func containsPost(_ newPost: Item) -> Bool {
        for post in posts {
            if post.name == newPost.name {
                return true
            }
        }
        return false
    }
}
