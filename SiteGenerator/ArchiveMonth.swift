import Foundation

class ArchiveMonth {
    
    private var _month: Int
    private var posts: [Item] = []
    
    var month: Int {
        get { return _month }
    }
    
    init(_ month: Int) {
        self._month = month
    }
    
    public func addPost(_ post: Item) {
        posts.append(post)
    }
    
    public func renderMonth() -> SmlNode {
        if posts.count > 0 {
            var liChildren: [SmlNode] = []
            let link = a([href => createLinkUrl()], [createLinkTitle()])
            liChildren.append(link)
            let l = li(liChildren)
            return l
        }
        else {
            return .text("")
        }
    }
    
    private func createLinkUrl() -> String {
        let post = posts[0]
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "yyyy/MM/"
        return Page.baseUrl + dateFormatter.string(from: post.date!)
    }
    
    private func createLinkTitle() -> SmlNode {
        let post = posts[0]
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "MMMM"
        return .text(dateFormatter.string(from: post.date!))
    }
}
