import Foundation

class PostBasicPage: Page {

    private let posts: [Item]
    private let basicTitle: String

    init(_ posts: [Item], basicTitle: String) {
        self.posts = posts
        self.basicTitle = basicTitle
    }

    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine, newLine]
        let h_1 = h1([.text(basicTitle)])
        mainChildren.append(h_1)

        for post in posts {
            mainChildren.append(post.renderBasicPost())
        }

        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
