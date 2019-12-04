import Foundation

let contentParser = ContentParser()
let posts = contentParser.parse()

let writer = PageWriter()

let page = HomePage(posts)
writer.writeHomePage(page.render())

for post: Item in posts {
    let page = PostPage(post)
    writer.writePostPage(post, page.render())
}

/*let s = "text1 [title](url) text2"
let elements = MarkdownParser.parse(text: s)

let smlBuilder = SmlBuilder()
print(smlBuilder.parse(elements))*/

