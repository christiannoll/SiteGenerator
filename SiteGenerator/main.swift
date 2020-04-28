import Foundation

//setenv("CFNETWORK_DIAGNOSTICS", "3", 1);

let contentParser = ContentParser()
var posts = contentParser.parse()
posts.sort { $0.date! > $1.date! }

let generator = SiteGenerator(posts)
generator.generate()

/*let verifier = PageVerifier(posts)
verifier.verify()

let statistics = SiteStatistics(posts)
statistics.writeStatisticPage()
statistics.writeCsvData()*/

