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
    
    func addPost(_ post: Item) {
        posts.append(post)
    }
    
    func renderIndexItem() -> SmlNode {
        var liChildren: [SmlNode] = []
        let link = a([href => createLinkUrl()], [createLinkTitle()])
        liChildren.append(link)
        let l = li(liChildren)
        return l
    }
    
    func renderIndexItemPosts() -> [SmlNode] {
        var indexItemPosts: [SmlNode] = [newLine]
        
        for post in posts {
            indexItemPosts.append(post.renderPost())
        }
        return indexItemPosts
    }
    
    private func createLinkUrl() -> String {
        return Page.baseUrl + "index/" + key.convertToUrlPath() + "/"
    }
    
    private func createLinkTitle() -> SmlNode {
        return .text(key + " (" + String(posts.count) + ")")
    }
}
