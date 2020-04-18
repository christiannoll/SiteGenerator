import Foundation

class SearchItem {
    
    private let post: Item
    private let index: Int
    private let postBuilder = PostBuilder()
    
    init(_ post: Item, _ index: Int) {
        self.post = post
        self.index = index
    }
    
    func renderSearchItem() -> SmlNode {
        var liChildren: [SmlNode] = []
        let link = postBuilder.createPostLink(post)
        liChildren.append(link)
        let l = li(index, liChildren)
        return l
    }
}
