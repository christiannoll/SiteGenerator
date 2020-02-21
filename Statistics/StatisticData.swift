import Foundation

struct StatisticData {
    
    var numberOfPosts: Int = 0
    var numberOfPhotos: Int = 0
    var numberOfIndexItems: Int = 0
    var numberOfTagItems: Int = 0
    var numberOfAllLinks: Int = 0
    var numberOfSerialItems: Int = 0
    var meanNumberOfLinks: Int = 0
    var meanNumberOfWords: Int = 0
    
    var postsData: [PostStatisticData] = []
}
