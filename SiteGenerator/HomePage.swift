import Foundation

class HomePage : Page {
    
    override func renderContent() -> String {
        let contentParser = ContentParser()
        let posts = contentParser.parse()
        
        var s = ""
        for post: Item in posts {
            s.append(post.renderPost())
        }
        return s
    }
}
