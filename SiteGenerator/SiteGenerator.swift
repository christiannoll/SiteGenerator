import Foundation

extension String {
    
    func convertToUrlPath() -> String {
        var path = self.folding(options: .diacriticInsensitive, locale: .current)
        path = path.replacingOccurrences(of: " ", with: "-")
        path = path.replacingOccurrences(of: ":", with: "-")
        return path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
    }
    
    func htmlEncodedString() -> String {
        return self.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&apos;")
    }
}

struct SiteGenerator {
    
    //static let baseDir = "/Users/chn/Programmierung/Swift/SiteGenerator/vnzn/en/"
    static let baseDir = "/Users/chn/Programmierung/Swift/SiteGenerator/vnzn/"
    
    private let posts: [Item]
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    static func forGerman() -> Bool {
        let lang = UserDefaults.standard.string(forKey: "AppleLanguage")
        return lang == "de"
    }
    
    func generate() {
        let ftpWriter = FtpScriptWriter()
        
        let writer = PageWriter()
        
        let homePage = HomePage(posts)
        writer.writeHomePage(homePage.render())
        
        for post in posts {
            let page = PostPage(post)
            writer.writePostPage(post, page.render())
        }
        
        let archiveFactory = ArchiveFactory()
        let archive = archiveFactory.createArchive(posts)
        let archivePage = ArchivePage(archive);
        writer.writeArchivePage(archivePage.render())
        
        let archiveYears = archive.years
        for year in archiveYears {
            for month in year.months {
                let page = ArchiveMonthPage(month)
                writer.writeArchiveMonthPage(month, page.render())
            }
        }
        
        let indexFactory = IndexFactory()
        let index = indexFactory.createIndex(posts)
        let indexPage = IndexPage(index)
        writer.writeIndexPage(indexPage.render())
        
        let indexItems = index.indexItems
        for indexItem in indexItems {
            let page = IndexItemPage(indexItem)
            writer.writeIndexItemPage(indexItem, page.render())
        }
        
        let tagsFactory = TagsFactory()
        let tags = tagsFactory.createTags(posts)
        let tagsPage = TagsPage(tags)
        writer.writeTagsPage(tagsPage.render())
        
        let tagItems = tags.tagItems
        for tagItem in tagItems {
            let page = TagItemPage(tagItem)
            writer.writeTagItemPage(tagItem, page.render())
        }
        
        let serialsFactory = SerialsFactory()
        let serials = serialsFactory.createSerials(posts)
        let serialsPage = SerialsPage(serials)
        writer.writeSerialsPage(serialsPage.render())
        
        let serialItems = serials.tagItems
        for serialItem in serialItems {
            let page = TagItemPage(serialItem)
            writer.writeSerialItemPage(serialItem, page.render())
        }
        
        if (SiteGenerator.forGerman()) {
            let impressumPage = ImpressumPage()
            writer.writeImpressumPage(impressumPage.render())
        }
        else {
            let contactPage = ContactPage()
            writer.writeImpressumPage(contactPage.render())
        }
        
        ftpWriter.writeScript()
        
        let rssFeed = RssFeed(posts)
        let feedWriter = FeedWriter()
        feedWriter.writeRssFeed(rssFeed.render())
        
        let searchItemsFactory = SearchItemsFactory()
        let searchItems = searchItemsFactory.createSearchItems(posts)
        let searchPage = SearchPage(searchItems)
        writer.writeSearchPage(searchPage.render())
        
        var searchIndexBuilder = SearchIndexBuilder()
        searchIndexBuilder.buildIndex(posts)
        searchIndexBuilder.writeJsFile()
    }
}
