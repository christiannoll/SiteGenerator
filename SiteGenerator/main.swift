import Foundation

let contentParser = ContentParser()
let posts = contentParser.parse()

for post: Item in posts {
    print(post.renderPost())
    print(" --- ")
}

/*let s = "text1 [title](url) text2"
let elements = MarkdownParser.parse(text: s)

let smlBuilder = SmlBuilder()
print(smlBuilder.parse(elements))*/

