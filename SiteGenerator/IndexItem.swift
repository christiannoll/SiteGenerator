import Foundation

class IndexItem {
    
    private let _key: String
    private var posts: [Item] = []
    private let postBuilder = PostBuilder()
    
    var key: String {
        get { return _key }
    }
    
    init(_ key: String) {
        self._key = key
    }
    
    public func addPost(_ post: Item) {
        posts.append(post)
    }
    
    public func renderIndexItem() -> SmlNode {
        var ulChildren: [SmlNode] = [newLine]
        
        for post: Item in posts {
            var liChildren: [SmlNode] = []
            let link = postBuilder.createPostLink(post)
            liChildren.append(link)
            let l = li(liChildren)
            ulChildren.append(l)
            ulChildren.append(newLine)
        }
        
        let u = ul(ulChildren)
        return u
    }
}
