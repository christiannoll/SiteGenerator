import Foundation

extension String {
    
    func convertToUrlPath() -> String {
        var path = self.folding(options: .diacriticInsensitive, locale: .current)
        path = path.replacingOccurrences(of: " ", with: "-")
        path = path.replacingOccurrences(of: ":", with: "-")
        path = path.replacingOccurrences(of: "'", with: "-")
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
    
    private let posts: [Item]
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    func generate() {
        let ftpWriter = FtpScriptWriter()
        
        let writer = PageWriter()
        
        let homePage = HomePage(posts)
        homePage.setTitle("weblog")
        writer.writeHomePage(homePage.render())
        
        for post in posts {
            let page = PostPage(post)
            page.setTitle(post.title)
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
        indexPage.setTitle()
        writer.writeIndexPage(indexPage.render())
        
        let indexItems = index.indexItems
        for indexItem in indexItems {
            let page = IndexItemPage(indexItem)
            page.setTitle(indexItem.key)
            writer.writeIndexItemPage(indexItem, page.render())
        }
        
        let tagsFactory = TagsFactory()
        let tags = tagsFactory.createTags(posts)
        let tagsPage = TagsPage(tags)
        tagsPage.setTitle()
        writer.writeTagsPage(tagsPage.render())
        
        let tagItems = tags.tagItems
        for tagItem in tagItems {
            let page = TagItemPage(tagItem)
            page.setTitle(page.key)
            writer.writeTagItemPage(tagItem, page.render())
        }
        
        let serialsFactory = SerialsFactory()
        let serials = serialsFactory.createSerials(posts)
        let serialsPage = SerialsPage(serials)
        serialsPage.setTitle()
        writer.writeSerialsPage(serialsPage.render())
        
        let serialItems = serials.tagItems
        for serialItem in serialItems {
            let page = TagItemPage(serialItem)
            page.setTitle(page.key)
            writer.writeSerialItemPage(serialItem, page.render())
        }
        
        if (SiteGeneratorEnv.forGerman()) {
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
        
        let randomEntriesBuilder = RandomEntriesBuilder()
        randomEntriesBuilder.writeJsFile(posts)
        
        writeTimelinePage(writer)
        writePersonsRegisterPage(writer)
        writeMoviesRegisterPage(writer)
        writeBooksRegisterPage(writer)
        writeWordCloudPage(writer)
        
        let betaPage = BetaPage()
        writer.writeBetaPage(betaPage.render())
    }
    
    private func writeTimelinePage(_ writer: PageWriter) {
        let timelineFactory = TimelineFactory()
        let timeline = timelineFactory.createTimeline(posts)
        let timelinePage = TimelinePage(timeline)
        writer.writeTimelinePage(timelinePage.render())
    }
    
    private func writePersonsRegisterPage(_ writer: PageWriter) {
        let personsRegisterFactory = PersonsRegisterFactory()
        let personsRegister = personsRegisterFactory.createPersonsRegister(posts)
        let personsRegisterPage = PersonsRegisterPage(personsRegister)
        writer.writePersonsRegisterPage(personsRegisterPage.render())
    }
    
    private func writeMoviesRegisterPage(_ writer: PageWriter) {
        let moviesRegisterFactory = MoviesRegisterFactory()
        let moviesRegister = moviesRegisterFactory.createMoviesRegister(posts)
        let moviesRegisterPage = MoviesRegisterPage(moviesRegister)
        writer.writeMoviesRegisterPage(moviesRegisterPage.render())
    }
    
    private func writeBooksRegisterPage(_ writer: PageWriter) {
        let booksRegisterFactory = BooksRegisterFactory()
        let booksRegister = booksRegisterFactory.createBooksRegister(posts)
        let booksRegisterPage = BooksRegisterPage(booksRegister)
        writer.writeBooksRegisterPage(booksRegisterPage.render())
    }
    
    private func writeWordCloudPage(_ writer: PageWriter) {
        let indexFactory = IndexFactory()
        let index = indexFactory.createIndex(posts)
        let wordCloudPage = WordCloudPage(index)
        writer.writeWordCloudPage(wordCloudPage.render())
    }
}
