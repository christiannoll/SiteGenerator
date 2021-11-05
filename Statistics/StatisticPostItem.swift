import Foundation

struct StatisticPostItem {
    
    let post: Item
    let number: Int
    
    private let postBuilder = PostBuilder()
    
    init(_ post: Item, _ number: Int) {
        self.post = post
        self.number = number
    }
    
    func renderPostLink() -> SmlNode {
        postBuilder.createPostLink(post)
    }
}
