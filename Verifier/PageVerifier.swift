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
        res = res && loadSerialsPage()
        res = res && loadSerialItemPages()

        res = res && loadImpressumPage()
        res = res && loadRssFile()
        res = res && validateNames()
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
        let linkParser = LinkParser()
        for post in posts {
            let markdownNodes = MarkdownParser.parse(text: post.data)
            var links: [String: String] = [:]
            linkParser.parse(markdownNodes, &links)
            links.forEach {
                res = res && loadUrl((SmlBuilder.buildUrl($0), $1))
            }
        }
        return res
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
    
    private func loadSerialsPage() -> Bool {
        return loadPage(relPath: "serials/index.html")
    }
    
    private func loadSerialItemPages() -> Bool {
        var res = true
        let serialsFactory = SerialsFactory()
        let serials = serialsFactory.createSerials(posts)
        
        let serialItems = serials.tagItems
        for serialItem in serialItems {
            let relPath = "serials/" + serialItem.key.convertToUrlPath() + "/index.html"
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
    
    private func loadRssFile() -> Bool {
        let parser = RssParser()
        let items = parser.parse()
        let ok = items.count == HomePage.max_number_of_posts
        if ok {
            print("OK- parsing RSS file")
        }
        else {
            print("ERROR- parsing RSS file")
        }
        return ok
    }
    
    private func validateNames() -> Bool {
        var res = true
        var names: Set<String> = []
        for post in posts {
            if names.insert(post.name).inserted == false {
                res = false
                print("ERROR- name: \(post.name) already exist")
                break
            }
        }
        return res
    }
}
