import Foundation

struct Sitemap {
    
    private let posts: [Item]
    
    init(posts: [Item]) {
        self.posts = posts
    }
    
    func render() -> String {
        var content = ""
        
        for post in posts {
            content.append(PostBuilder.createPostUrl(post) + "index.html")
            content.append("\n")
        }
        
        return content
    }
}
