import Foundation

let generator = SiteGenerator()
generator.generate()

let verifier = PageVerifier()
verifier.verify()

/*let s = "text1 [title](url) text2"
let elements = MarkdownParser.parse(text: s)

let smlBuilder = SmlBuilder()
print(smlBuilder.parse(elements))*/


