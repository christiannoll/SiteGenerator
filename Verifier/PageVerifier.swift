import Foundation

class PageVerifier {
    
    private let posts: [Item]
    
    init() {
        let contentParser = ContentParser()
        posts = contentParser.parse()
    }
    
    func verify() {
        loadHomePage()
        loadPostPages()
    }
    
    private func loadHomePage() {
        loadPage(relPath: "/index.html")
    }
    
    private func loadPostPages() {
        for post in posts {
            var relPath = ""
            relPath.append(PostBuilder.createDatePath(post))
            relPath.append(post.name)
            relPath.append("/index.html")
            loadPage(relPath: relPath)
        }
    }
    
    private func loadPage(relPath: String) {
        let pageLoader = PageLoader()
        pageLoader.loadPage(from: Page.baseUrl + relPath) { (response, urlString) in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Error- loading: " + urlString)
                return
            }
            print("OK- loading: " + urlString)
        }
    }
}
