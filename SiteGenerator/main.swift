import Foundation

let contentParser = ContentParser()
let posts = contentParser.parse()

let page = HomePage(posts)
print(page.render())

/*let s = "text1 [title](url) text2"
let elements = MarkdownParser.parse(text: s)

let smlBuilder = SmlBuilder()
print(smlBuilder.parse(elements))*/

