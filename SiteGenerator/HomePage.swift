import Foundation

class HomePage : Page {
    
    private let posts: [Item]
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        for post: Item in posts {
            mainChildren.append(post.renderPost())
        }
        
        mainChildren.append(newLine)
        let link = a([href => (Page.baseUrl + "achive")], ["Archiv"])
        let para = p([link])
        mainChildren.append(para)
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    private func main(_ children: [SmlNode]) -> SmlNode {
        return node("main", children)
    }
}
