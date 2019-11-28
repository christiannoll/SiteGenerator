import Foundation

let contentParser = ContentParser()
let posts = contentParser.parse()

for post: Item in posts {
    let smlBuilder = SmlBuilder()
    print(smlBuilder.createArticle(post).render())
    
    let date = post.date
    if date != nil {
        let testFormatter = DateFormatter()
        testFormatter.dateFormat = "d MMM yyyy"
        print(testFormatter.string(from: date!))
    }
    print(" --- ")
}

/*let s = "text1 [title](url) text2"
let elements = MarkdownParser.parse(text: s)

let smlBuilder = SmlBuilder()
print(smlBuilder.parse(elements))*/

