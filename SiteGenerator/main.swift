import Foundation

let contentParser = ContentParser()
let posts = contentParser.parse()

let generator = SiteGenerator(posts)
generator.generate()

let verifier = PageVerifier(posts)
verifier.verify()

let statistics = SiteStatistics(posts)
statistics.writeStatisticPage()

