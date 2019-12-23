import Foundation

class SiteStatistics {
    
    private let posts: [Item]
    private var data: StatisticData
    
    init(_ posts: [Item]) {
        self.posts = posts
        data = StatisticData()
    }
    
    func writeStatisticPage() {
        analyze()
        let page = StatisticPage(data)
        
        let writer = PageWriter()
        writer.writeStatisticPage(page.render())
    }
    
    private func analyze() {
        data.numberOfPosts = posts.count
        
        for post in posts {
            if post as? ImagePost != nil {
                data.numberOfPhotos += 1
            }
        }
        
        let indexFactory = IndexFactory()
        let index = indexFactory.createIndex(posts)
        data.numberOfIndexItems = index.numberOfIndexItems
        
        let tagsFactory = TagsFactory()
        let tags = tagsFactory.createTags(posts)
        data.numberOfTagItems = tags.numberOfTagItems
    }
}
