import Foundation

class PageVerifier {
    
    private let posts: [Item]
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    func verify() {
        var res = true
        res = res && loadHomePage()
        res = res && loadPostPages()
        res = res && loadPostLinks()
        res = res && loadArchivePage()
        res = res && loadArchiveMonthPages()
        res = res && loadIndexPage()
        res = res && loadIndexItemPages()
        res = res && loadTagsPage()
        res = res && loadTagItemPages()
        res = res && loadImpressumPage()
        print("\nVERIFIER RESULT: \(res ? "OK" : "ERROR")")
    }
    
    private func loadHomePage() -> Bool {
        return loadPage(relPath: "index.html")
    }
    
    private func loadPostPages() -> Bool {
        var res = true
        for post in posts {
            var relPath = ""
            relPath.append(PostBuilder.createDatePath(post))
            relPath.append(post.name)
            relPath.append("/index.html")
            res = res && loadPage(relPath: relPath)
        }
        return res
    }
    
    private func loadPostLinks() -> Bool {
        var res = true
        for post in posts {
            let markdownNodes = MarkdownParser.parse(text: post.data)
            var links: [String: String] = [:]
            parse(markdownNodes, &links)
            links.forEach {
                res = res && loadUrl((SmlBuilder.buildUrl($0), $1))
            }
        }
        return res
    }
    
    private func parse(_ markdownNodes: [MarkdownNode], _ links: inout [String: String]) {
        for markDownNode in markdownNodes {
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
        for markDownNode in markdownNodes {
            switch markDownNode {
            case .parenthesis(let nodes):
                strings.append(parseLinkText(nodes))
            case .brackets(let nodes):
                strings.append(parseLinkText(nodes))
            default:
                break
            }
        }
    }
    
    private func parseLinkText(_ markdownNodes: [MarkdownNode]) -> String {
        var s = ""
        for markDownNode in markdownNodes {
            switch markDownNode {
            case .text(let text):
                s.append(text)
            default:
                break
            }
        }
        return s
    }
    
    private func loadArchivePage() -> Bool {
        return loadPage(relPath: "archive/index.html")
    }
    
    private func loadArchiveMonthPages() -> Bool {
        var res = true
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
                res = res && loadPage(relPath: relPath)
            }
        }
        return res
    }
    
    private func loadIndexPage() -> Bool {
        return loadPage(relPath: "index/index.html")
    }
    
    private func loadIndexItemPages() -> Bool {
        var res = true
        let indexFactory = IndexFactory()
        let index = indexFactory.createIndex(posts)
        
        let indexItems = index.indexItems
        for indexItem in indexItems {
            let relPath = "index/" + indexItem.key.convertToUrlPath() + "/index.html"
            res = res && loadPage(relPath: relPath)
        }
        return res
    }
    
    private func loadTagsPage() -> Bool {
        return loadPage(relPath: "tags/index.html")
    }
    
    private func loadTagItemPages() -> Bool {
        var res = true
        let tagsFactory = TagsFactory()
        let tags = tagsFactory.createTags(posts)
        
        let tagItems = tags.tagItems
        for tagItem in tagItems {
            let relPath = "tags/" + tagItem.key.convertToUrlPath() + "/index.html"
            res = res && loadPage(relPath: relPath)
        }
        return res
    }
    
    private func loadImpressumPage() -> Bool {
        return loadPage(relPath: "impressum/index.html")
    }
    
    private func loadPage(relPath: String) -> Bool {
        var res = false
        let pageLoader = PageLoader()
        
        pageLoader.loadPage(from: Page.baseUrl + relPath) { (response, urlString) in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Error- loading page: " + urlString)
                return
            }
            print("OK- loading page: " + urlString)
            res = true
        }
        return res
    }
    
    private func loadUrl(_ link: (String,String)) -> Bool {
        var res = false
        let pageLoader = PageLoader()
        
        pageLoader.loadPage(from: link.0) { (response, urlString) in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Error- loading \(link.1): " + urlString)
                return
            }
            print("OK- loading \(link.1): " + urlString)
            res = true
        }
        return res
    }
}
