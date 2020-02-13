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
        
        for post in posts {
            var postData = PostStatisticData()
            if post as? ImagePost != nil {
                data.numberOfPhotos += 1
                postData.imagePost = true
            }
            else {
                postData.wordCount = calcWordCount(post)
                postData.linkCount = calcNumberOfLinks(post)
                numberOfAllLinks += postData.linkCount
            }
            postData.publishDate = convertDateToString(post)
            postData.serialPost = post.serial.count > 0
            data.postsData.append(postData)
            data.numberOfAllLinks = numberOfAllLinks
        }
        
        let indexFactory = IndexFactory()
        let index = indexFactory.createIndex(posts)
        data.numberOfIndexItems = index.numberOfIndexItems
        
        let tagsFactory = TagsFactory()
        let tags = tagsFactory.createTags(posts)
        data.numberOfTagItems = tags.numberOfTagItems
        
        let serialsFactory = SerialsFactory()
        let serials = serialsFactory.createSerials(posts)
        data.numberOfSerialItems = serials.numberOfTagItems
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
    
    private func calcNumberOfLinks(_ post: Item) -> Int {
        let markdownNodes = MarkdownParser.parse(text: post.data)
        return parse(markdownNodes)
    }
    
    private func parse(_ markdownNodes: [MarkdownNode]) -> Int {
        var numberOfLinks = 0
        for markDownNode in markdownNodes {
            switch markDownNode {
            case .bold(let nodes):
                numberOfLinks += parse(nodes)
            case .italic(let nodes):
                numberOfLinks += parse(nodes)
            case .parenthesis(let nodes):
                numberOfLinks += parse(nodes)
            case .brackets(let nodes):
                numberOfLinks += parse(nodes)
            case .olistelement(let nodes):
                numberOfLinks += parse(nodes)
            case .ulistelement(let nodes):
                numberOfLinks += parse(nodes)
            case .link(let nodes):
                numberOfLinks += 1
                numberOfLinks += parse(nodes)
            case .ulist(let nodes):
                numberOfLinks += parse(nodes)
            case .olist(let nodes):
                numberOfLinks += parse(nodes)
            default:
                break
            }
        }
        return numberOfLinks
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
}
