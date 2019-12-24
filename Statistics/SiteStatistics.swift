import Foundation

class SiteStatistics {
    
    private let posts: [Item]
    private var data: StatisticData
    
    init(_ posts: [Item]) {
        self.posts = posts
        data = StatisticData()
        
        analyze()
    }
    
    func writeStatisticPage() {
        let page = StatisticPage(data)
        
        let writer = PageWriter()
        writer.writeStatisticPage(page.render())
    }
    
    func writeCsvData() {
        let csvWriter = CsvWriter()
        csvWriter.writeData(data)
    }
    
    private func analyze() {
        data.numberOfPosts = posts.count
        
        for post in posts {
            var postData = PostStatisticData()
            if post as? ImagePost != nil {
                data.numberOfPhotos += 1
                postData.imagePost = true
            }
            else {
                postData.wordCount = calcWordCount(post)
            }
            postData.publishDate = convertDateToString(post)
            data.postsData.append(postData)
        }
        
        let indexFactory = IndexFactory()
        let index = indexFactory.createIndex(posts)
        data.numberOfIndexItems = index.numberOfIndexItems
        
        let tagsFactory = TagsFactory()
        let tags = tagsFactory.createTags(posts)
        data.numberOfTagItems = tags.numberOfTagItems
    }
    
    private func calcWordCount(_ post: Item) -> Int {
        var number = 0
        let words = post.data.components(separatedBy: CharacterSet.whitespaceAndPunctuation)
        for word in words {
            if word.count > 1 {
                number += 1
            }
        }
        return number
    }
    
    private func convertDateToString(_ post: Item) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale.init(identifier: "de_DE")
        
        return dateFormatter.string(from: post.date!)
    }
}
