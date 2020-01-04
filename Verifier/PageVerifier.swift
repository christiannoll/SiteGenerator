import Foundation

class PageVerifier {
    
    private let posts: [Item]
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    func verify() {
        loadHomePage()
        loadPostPages()
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
                relPath.append(String(month.month))
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
                print("Error- loading: " + urlString)
                return
            }
            print("OK- loading: " + urlString)
        }
    }
}
