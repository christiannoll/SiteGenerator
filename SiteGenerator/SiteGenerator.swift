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
        
        let shuffledHomePage = HomePage(shuffledPosts())
        shuffledHomePage.setTitle("weblog")
        writer.writeShuffledHomePage(shuffledHomePage.render())
        
        let maxHomePage = MaxHomePage(posts)
        maxHomePage.setTitle("weblog")
        writer.writeMaxHomePage(maxHomePage.render())
        
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
            page.setTitle(tagItem.key)
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
            page.setTitle(serialItem.key)
            writer.writeSerialItemPage(serialItem, page.render())
        }
        
        if (SiteGeneratorEnv.forGerman()) {
            let impressumPage = ImpressumPage()
            impressumPage.setTitle()
            writer.writeImpressumPage(impressumPage.render())
        }
        else {
            let contactPage = ContactPage()
            contactPage.setTitle()
            writer.writeImpressumPage(contactPage.render())
        }
        
        ftpWriter.writeScript()
        
        let rssFeed = RssFeed(posts)
        let feedWriter = FeedWriter()
        feedWriter.writeRssFeed(rssFeed.render())
        
        let searchItemsFactory = SearchItemsFactory()
        let searchItems = searchItemsFactory.createSearchItems(posts)
        let searchPage = SearchPage(searchItems)
        searchPage.setTitle()
        writer.writeSearchPage(searchPage.render())
        
        let advancedSearchPage = AdvancedSearchPage(searchItems)
        writer.writeAdvancedSearchPage(advancedSearchPage.render())
        
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
        betaPage.setTitle()
        writer.writeBetaPage(betaPage.render())
        
        let experimentsPage = ExperimentsPage()
        experimentsPage.setTitle()
        writer.writeExperimentsPage(experimentsPage.render())
        
        let sitemap = Sitemap(posts: posts, relativePagePaths: writer.relativePagePaths)
        let sitemapWriter = SitemapWriter()
        sitemapWriter.writeSitemap(sitemap.render())
    }
    
    private func writeTimelinePage(_ writer: PageWriter) {
        let timelineFactory = TimelineFactory()
        let timeline = timelineFactory.createTimeline(posts)
        let timelinePage = TimelinePage(timeline)
        timelinePage.setTitle()
        writer.writeTimelinePage(timelinePage.render())
    }
    
    private func writePersonsRegisterPage(_ writer: PageWriter) {
        let personsRegisterFactory = PersonsRegisterFactory()
        let personsRegister = personsRegisterFactory.createPersonsRegister(posts)
        let personsRegisterPage = PersonsRegisterPage(personsRegister)
        personsRegisterPage.setTitle()
        writer.writePersonsRegisterPage(personsRegisterPage.render())
        
        let personCloudPage = PersonCloudPage(personsRegister)
        personCloudPage.setTitle()
        writer.writePersonCloudPage(personCloudPage.render())
    }
    
    private func writeMoviesRegisterPage(_ writer: PageWriter) {
        let moviesRegisterFactory = MoviesRegisterFactory()
        let moviesRegister = moviesRegisterFactory.createMoviesRegister(posts)
        let moviesRegisterPage = MoviesRegisterPage(moviesRegister)
        moviesRegisterPage.setTitle()
        writer.writeMoviesRegisterPage(moviesRegisterPage.render())
    }
    
    private func writeBooksRegisterPage(_ writer: PageWriter) {
        let booksRegisterFactory = BooksRegisterFactory()
        let booksRegister = booksRegisterFactory.createBooksRegister(posts)
        let booksRegisterPage = BooksRegisterPage(booksRegister)
        booksRegisterPage.setTitle()
        writer.writeBooksRegisterPage(booksRegisterPage.render())
    }
    
    private func writeWordCloudPage(_ writer: PageWriter) {
        let indexFactory = IndexFactory()
        let index = indexFactory.createIndex(posts)
        let wordCloudPage = WordCloudPage(index)
        wordCloudPage.setTitle()
        writer.writeWordCloudPage(wordCloudPage.render())
    }
    
    private func shuffledPosts() -> [Item] {
        var shuffledPosts: [Item] = []
        
        var textPosts: [Item] = []
        var imagePosts: [Item] = []
        
        for post in posts {
            if post.itemType() == .text {
                textPosts.append(post)
            }
            else {
                imagePosts.append(post)
            }
        }
        
        textPosts.shuffle()
        imagePosts.shuffle()
        
        var index = 0
        var imageIndex = 0
        while index + 1 < textPosts.count {
            shuffledPosts.append(textPosts[index])
            index += 1
            shuffledPosts.append(textPosts[index])
            index += 1
            if imageIndex < imagePosts.count {
                shuffledPosts.append(imagePosts[imageIndex])
                imageIndex += 1
            }
        }
        
        return shuffledPosts
    }
}
