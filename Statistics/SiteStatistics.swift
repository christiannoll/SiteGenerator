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
        var numberOfAllLinks = 0
        var numberOfTextPosts = 0
        var numberOfAllWords = 0
        
        for post in posts {
            var postData = PostStatisticData(postItem: post)
            if post as? ImagePost != nil {
                data.numberOfPhotos += 1
                postData.imagePost = true
            }
            else {
                postData.wordCount = calcWordCount(post)
                postData.linkCount = post.links.count
                numberOfAllLinks += postData.linkCount
                numberOfTextPosts += 1
                numberOfAllWords += postData.wordCount
            }
            postData.publishDate = convertDateToString(post)
            postData.serialPost = post.serial.count > 0
            data.postsData.append(postData)
            data.numberOfAllLinks = numberOfAllLinks
        }
        
        data.meanNumberOfLinks = numberOfAllLinks / numberOfTextPosts
        data.meanNumberOfWords = numberOfAllWords / numberOfTextPosts
        
        let indexFactory = IndexFactory()
        let index = indexFactory.createIndex(posts)
        data.numberOfIndexItems = index.numberOfIndexItems
        
        let tagsFactory = TagsFactory()
        let tags = tagsFactory.createTags(posts)
        data.numberOfTagItems = tags.numberOfTagItems
        
        let serialsFactory = SerialsFactory()
        let serials = serialsFactory.createSerials(posts)
        data.numberOfSerialItems = serials.numberOfTagItems
        
        sortByWordCount()
        calculateMaxWordCountPost()
        calculateMinWordCountPost()
        
        sortByLinkCount()
        calculateMaxLinkCountPost()
    }
    
    private func calcWordCount(_ post: Item) -> Int {
        let markdownNodes = MarkdownParser.parse(text: post.data)
        return parseNumberOfWords(markdownNodes)
    }
    
    private func convertDateToString(_ post: Item) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale.init(identifier: "de_DE")
        
        return dateFormatter.string(from: post.date!)
    }
    
    private func parseNumberOfWords(_ markdownNodes: [MarkdownNode]) -> Int {
        var numberOfWords = 0
        for markDownNode in markdownNodes {
            switch markDownNode {
            case .text(let text):
                let words = text.components(separatedBy: CharacterSet.whitespaceAndPunctuation)
                for word in words {
                    if word.count > 1 {
                        numberOfWords += 1
                    }
                }
            case .bold(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            case .italic(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            case .code(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            case .color(_, let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            case .parenthesis(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            case .brackets(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            case .olistelement(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            case .ulistelement(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            case .link(let nodes):
                numberOfWords += parseNumberOfWordsInLink(nodes)
            case .ulist(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            case .olist(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            default:
                break
            }
        }
        return numberOfWords
    }
    
    private func parseNumberOfWordsInLink(_ markdownNodes: [MarkdownNode]) -> Int {
        var numberOfWords = 0
        for markDownNode in markdownNodes {
            switch markDownNode {
            case .brackets(let nodes):
                numberOfWords += parseNumberOfWords(nodes)
            default:
                break
            }
        }
        return numberOfWords
    }
    
    private func calculateMaxWordCountPost() {
        if !data.postsData.isEmpty {
            data.maxWordCountPostItem = StatisticPostItem(data.postsData.last!.postItem, data.postsData.last!.wordCount)
        }
    }
    
    private func calculateMinWordCountPost() {
        for postStatisticData in data.postsData {
            if postStatisticData.wordCount > 0 {
                data.minWordCountPostItem = StatisticPostItem(postStatisticData.postItem, postStatisticData.wordCount)
                break
            }
        }
    }
    
    private func calculateMaxLinkCountPost() {
        if !data.postsData.isEmpty {
            data.maxLinkCountPostItem = StatisticPostItem(data.postsData.last!.postItem, data.postsData.last!.linkCount)
        }
    }
    
    private func sortByWordCount() {
        data.postsData.sort { $0.wordCount < $1.wordCount }
    }
    
    private func sortByLinkCount() {
        data.postsData.sort { $0.linkCount < $1.linkCount }
    }
}
