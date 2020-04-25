import Foundation

struct SearchItem {
    
    private let post: Item
    private let postBuilder = PostBuilder()
    
    init(_ post: Item) {
        self.post = post
    }
    
    func renderSearchItem() -> SmlNode {
        var liChildren: [SmlNode] = []
        let link = postBuilder.createPostLink(post)
        liChildren.append(link)
        let l = li(post.id, liChildren)
        return l
    }
}
