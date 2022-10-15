import Foundation

struct Sitemap {
    
    private let posts: [Item]
    private let relativePagePaths: [String]
    
    init(posts: [Item], relativePagePaths: [String]) {
        self.posts = posts
        self.relativePagePaths = relativePagePaths
    }
    
    func render() -> String {
        var content = ""
        
        for post in posts {
            content.append(PostBuilder.createPostUrl(post) + "index.html")
            content.append("\n")
        }
        
        for path in relativePagePaths {
            let url = Page.baseUrl + path
            content.append(url)
            content.append("\n")
        }
        
        return content
    }
}
