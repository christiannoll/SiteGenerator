import Foundation

class TimelineItem {
    
    private let _year: Int
    private var posts: [Item] = []
    private let postBuilder = PostBuilder()
 
    init(_ year: Int) {
        self._year = year
    }
    
    var year: Int {
        get { return _year }
    }
    
    func addPost(_ post: Item) {
        if !containsPost(post) {
            posts.append(post)
        }
    }
    
    func renderTimelineItem() -> SmlNode {
        if posts.count > 0 {
            var ulChildren: [SmlNode] = []
            
            for post in posts {
                ulChildren.append(renderYear(post))
                ulChildren.append(newLine)
            }
            
            let u = ul(ulChildren)
            return u
        }
        else {
            return .text("")
        }
    }
    
    private func renderYear(_ post: Item) -> SmlNode {
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
