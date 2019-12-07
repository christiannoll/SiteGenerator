class TagItem {
    
    private let _key: String
    private var posts: [Item] = []
    
    var key: String {
        get { return _key }
    }
    
    init(_ key: String) {
        self._key = key
    }
    
    public func addPost(_ post: Item) {
        posts.append(post)
    }
    
    public func renderTagItem() -> SmlNode {
        var liChildren: [SmlNode] = []
        let link = a([href => createLinkUrl()], [createLinkTitle()])
        liChildren.append(link)
        let l = li(liChildren)
        return l
    }
    
    public func renderTagItemPosts() -> [SmlNode] {
        var tagItemPosts: [SmlNode] = [newLine]
        
        for post: Item in posts {
            tagItemPosts.append(post.renderPost())
        }
        return tagItemPosts
    }
    
    private func createLinkUrl() -> String {
        return Page.baseUrl + "tags/" + key + "/"
    }
    
    private func createLinkTitle() -> SmlNode {
        return .text(key + " (" + String(posts.count) + ")")
    }
}
