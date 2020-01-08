import Foundation

class PageVerifier {
    
    private let posts: [Item]
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    func verify() {
        loadHomePage()
        loadPostPages()
        loadPostLinks()
        loadArchivePage()
        loadArchiveMonthPages()
        loadIndexPage()
        loadIndexItemPages()
        loadTagsPage()
        loadTagItemPages()
        loadImpressumPage()
    }
    
    private func loadHomePage() {
        loadPage(relPath: "index.html")
    }
    
    private func loadPostPages() {
        for post in posts {
            var relPath = ""
            relPath.append(PostBuilder.createDatePath(post))
            relPath.append(post.name)
            relPath.append("/index.html")
            loadPage(relPath: relPath)
        }
    }
    
    private func loadPostLinks() {
        for post in posts {
            let markdownNodes = MarkdownParser.parse(text: post.data)
            var links: [String: String] = [:]
            parse(markdownNodes, &links)
            links.forEach { loadUrl(($0,$1)) }
        }
    }
    
    private func parse(_ markdownNodes: [MarkdownNode], _ links: inout [String: String]) {
        for markDownNode: MarkdownNode in markdownNodes {
            switch markDownNode {
            case .bold(let nodes):
                parse(nodes, &links)
            case .italic(let nodes):
                parse(nodes, &links)
            case .parenthesis(let nodes):
                parse(nodes, &links)
            case .brackets(let nodes):
                parse(nodes, &links)
            case .olistelement(let nodes):
                parse(nodes, &links)
            case .ulistelement(let nodes):
                parse(nodes, &links)
            case .link(let nodes):
                var strings: [String] = []
                parseLink(nodes, &strings)
                if strings.count == 2 {
                    links[strings[0]] = strings[1]
                }
            case .ulist(let nodes):
                parse(nodes, &links)
            case .olist(let nodes):
                parse(nodes, &links)
            default:
                break
            }
        }
    }
    
    private func parseLink(_ markdownNodes: [MarkdownNode], _ strings: inout [String]) {
        for markDownNode: MarkdownNode in markdownNodes {
            switch markDownNode {
            case .text(let text):
                strings.append(text)
            case .parenthesis(let nodes):
                parseLink(nodes, &strings)
            case .brackets(let nodes):
                parseLink(nodes, &strings)
            default:
                break
            }
        }
    }
    
    private func loadArchivePage() {
        loadPage(relPath: "archive/index.html")
    }
    
    private func loadArchiveMonthPages() {
        let archiveFactory = ArchiveFactory()
        let archive = archiveFactory.createArchive(posts)
        
        let archiveYears = archive.years
        for year in archiveYears {
            for month in year.months {
                var relPath = month.yearName + "/"
                var monthStr = String(month.month)
                if monthStr.count == 1 {
                    monthStr = "0" + monthStr
                }
                relPath.append(monthStr)
                relPath.append("/index.html")
                loadPage(relPath: relPath)
            }
        }
    }
    
    private func loadIndexPage() {
        loadPage(relPath: "index/index.html")
    }
    
    private func loadIndexItemPages() {
        let indexFactory = IndexFactory()
        let index = indexFactory.createIndex(posts)
        
        let indexItems = index.indexItems
        for indexItem in indexItems {
            let relPath = "index/" + indexItem.key.convertToUrlPath() + "/index.html"
            loadPage(relPath: relPath)
        }
    }
    
    private func loadTagsPage() {
        loadPage(relPath: "tags/index.html")
    }
    
    private func loadTagItemPages() {
        let tagsFactory = TagsFactory()
        let tags = tagsFactory.createTags(posts)
        
        let tagItems = tags.tagItems
        for tagItem in tagItems {
            let relPath = "tags/" + tagItem.key.convertToUrlPath() + "/index.html"
            loadPage(relPath: relPath)
        }
    }
    
    private func loadImpressumPage() {
        loadPage(relPath: "impressum/index.html")
    }
    
    private func loadPage(relPath: String) {
        let pageLoader = PageLoader()
        pageLoader.loadPage(from: Page.baseUrl + relPath) { (response, urlString) in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Error- loading page: " + urlString)
                return
            }
            print("OK- loading page: " + urlString)
        }
    }
    
    private func loadUrl(_ link: (String,String)) {
        let pageLoader = PageLoader()
        pageLoader.loadPage(from: link.0) { (response, urlString) in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Error- loading \(link.1): " + urlString)
                return
            }
            print("OK- loading \(link.1): " + urlString)
        }
    }
}
