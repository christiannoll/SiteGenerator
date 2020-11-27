import Foundation

class ArchiveMonth {
    
    private var _month: Int
    private var _year: Int
    private var posts: [Item] = []
    
    var month: Int {
        get { return _month }
    }
    
    var monthName: String {
        get { return getMonthName() }
    }
    
    var yearName: String {
        get { return String(_year) }
    }
    
    init(_ month: Int, _ year: Int) {
        _month = month
        _year = year
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
    
    public func renderMonthPosts() -> [SmlNode] {
        var monthPosts: [SmlNode] = [newLine]
        
        for post in posts {
            monthPosts.append(post.renderPost())
        }
        return monthPosts
    }
    
    private func createLinkUrl() -> String {
        let post = posts[0]
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "yyyy/MM/"
        return Page.baseUrl + dateFormatter.string(from: post.date!)
    }
    
    private func createLinkTitle() -> SmlNode {
        return .text(getMonthName())
    }
    
    private func getMonthName() -> String {
        let post = posts[0]
        let dateFormatter = DateFormatter()
        if (SiteGeneratorEnv.forGerman()) {
            dateFormatter.locale = Locale(identifier: "de_DE")
        }
        else {
            dateFormatter.locale = Locale(identifier: "en_US")
        }
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: post.date!)
    }
}
