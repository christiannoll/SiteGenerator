import Foundation

class ArtPage: Page {

    private var posts: [Item]

    init(_ posts: [Item]) {
        self.posts = posts
    }

    var title: String {
        get { artTitle }
    }

    override func renderContent() -> SmlNode {
        var index = 0
        var mainChildren: [SmlNode] = [newLine]
        var containerPosts: [Item] = []

        for post in posts where post.itemType() == .image {
            containerPosts.append(post)
            if (index + 1) % 3 == 0 {
                mainChildren.append(renderContainer(posts: containerPosts))
                mainChildren.append(newLine)
                containerPosts.removeAll()
            }
            index += 1
        }

        mainChildren.append(newLine)
        return main(mainChildren)
    }

    func setTitle() {
        setTitle(artTitle)
    }

    private func renderContainer(posts: [Item]) -> SmlNode {
        var divChildren: [SmlNode] = []
        for (index, post) in posts.enumerated() {
            divChildren.append(renderItem(post, index))
        }
        let div = div_flexContainer(divChildren)
        return div
    }

    private func renderItem(_ item: Item, _ index: Int) -> SmlNode {
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)

        let postBody = item.renderArtPost()
        divChildren.append(postBody)

        divChildren.append(newLine)
        var div: SmlNode
        switch index {
        case 0:
            div = div_flexItemLeft(divChildren)
        case 1:
            div = div_flexItemMiddle(divChildren)
        default:
            div = div_flexItemRight(divChildren)
        }
        return div
    }

    private func createImageUrl(_ item: Item) -> String {
        var url = Page.baseRootUrl
        url.append("images/")
        url.append(item.data)
        return url
    }
}
