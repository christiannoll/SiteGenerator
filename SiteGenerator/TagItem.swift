class TagItem {
    
    private let _key: String
    private let folderName: String
    private var posts: [Item] = []
    
    var key: String {
        get { return _key }
    }
    
    init(_ key: String, _ folderName: String) {
        self._key = key
        self.folderName = folderName
    }
    
    func addPost(_ post: Item) {
        posts.append(post)
    }
    
    func renderTagItem() -> SmlNode {
        var liChildren: [SmlNode] = []
        let link = a([href => createLinkUrl()], [createLinkTitle()])
        liChildren.append(link)
        let l = li(liChildren)
        return l
    }
    
    func renderTagItemPosts() -> [SmlNode] {
        var tagItemPosts: [SmlNode] = [newLine]
        
        for post in posts {
            tagItemPosts.append(post.renderPost())
        }
        return tagItemPosts
    }
    
    private func createLinkUrl() -> String {
        return Page.baseUrl + folderName + key.convertToUrlPath() + "/"
    }
    
    private func createLinkTitle() -> SmlNode {
        return .text(key + " (" + String(posts.count) + ")")
    }
}
