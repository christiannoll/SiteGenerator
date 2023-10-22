import Foundation

class PageWriter {
    
    private var paths: [String] = []
    
    var relativePagePaths: [String] {
        get { return paths }
    }
    
    public func writeHomePage(_ content: String) {
        writeHtmlFile(content, "", "index.html")
    }
    
    public func writePostPage(_ item: Item, _ content: String) {
        var relPath = ""
        relPath.append(PostBuilder.createDatePath(item))
        relPath.append(item.name)
        relPath.append("/")
        writeHtmlFile(content, relPath, "index.html")
    }
    
    public func writeArchivePage(_ content: String) {
        writeHtmlFile(content, "archive/", "index.html")
    }
    
    public func writeArchiveMonthPage(_ archiveMonth: ArchiveMonth, _ content: String) {
        var relPath = archiveMonth.yearName + "/"
        var month = String(archiveMonth.month)
        if month.count == 1 {
            month = "0" + month
        }
        relPath.append(month)
        relPath.append("/")
        writeHtmlFile(content, relPath, "index.html")
    }
    
    public func writeIndexPage(_ content: String) {
        writeHtmlFile(content, "index/", "index.html")
    }
    
    public func writeIndexItemPage(_ indexItem: IndexItem, _ content: String) {
        let relPath = "index/" + indexItem.key.convertToUrlPath() + "/"
        writeHtmlFile(content, relPath, "index.html")
    }
    
    public func writeTagsPage(_ content: String) {
        writeHtmlFile(content, "tags/", "index.html")
    }
    
    public func writeSerialsPage(_ content: String) {
        writeHtmlFile(content, "serials/", "index.html")
    }
    
    public func writeTagItemPage(_ tagItem: TagItem, _ content: String) {
        let relPath = "tags/" + tagItem.key.convertToUrlPath() + "/"
        writeHtmlFile(content, relPath, "index.html")
    }
    
    public func writeSerialItemPage(_ tagItem: TagItem, _ content: String) {
        let relPath = "serials/" + tagItem.key.convertToUrlPath() + "/"
        writeHtmlFile(content, relPath, "index.html")
    }
    
    public func writeImpressumPage(_ content: String) {
        writeHtmlFile(content, "impressum/", "index.html")
    }
    
    public func writeStatisticPage(_ content: String) {
        writeHtmlFile(content, "statistic/", "index.html")
    }
    
    public func writeSearchPage(_ content: String) {
        writeHtmlFile(content, "search/", "index.html")
    }
    
    public func writeAdvancedSearchPage(_ content: String) {
        writeHtmlFile(content, "search/", "advancedSearch.html")
    }
    
    public func writeTimelinePage(_ content: String) {
        writeHtmlFile(content, "timeline/", "index.html")
    }
    
    public func writePersonsRegisterPage(_ content: String) {
        writeHtmlFile(content, "persons/", "index.html")
    }
    
    public func writeMoviesRegisterPage(_ content: String) {
        writeHtmlFile(content, "movies/", "index.html")
    }
    
    public func writeBooksRegisterPage(_ content: String) {
        writeHtmlFile(content, "books/", "index.html")
    }
    
    public func writeWordCloudPage(_ content: String) {
        writeHtmlFile(content, "wordcloud/", "index.html")
    }
    
    public func writePersonCloudPage(_ content: String) {
        writeHtmlFile(content, "personcloud/", "index.html")
    }
    
    public func writeErrorPage(_ content: String, errorNumber: String) {
        writeHtmlFile(content, "error/", "error_" + errorNumber + ".html")
    }
    
    public func writeBetaPage(_ content: String) {
        writeHtmlFile(content, "beta/", "index.html")
    }
    
    public func writeExperimentsPage(_ content: String) {
        writeHtmlFile(content, "experiments/", "index.html")
    }
    
    public func writeShuffledHomePage(_ content: String) {
        writeHtmlFile(content, "shuffled/", "index.html")
    }
    
    public func writeMaxHomePage(_ content: String) {
        writeHtmlFile(content, "max/", "index.html")
    }
    
    private func writeHtmlFile(_ content: String, _ relPath: String, _ fileName: String) {
        do {
            let htmlContent = "<!DOCTYPE html>\n" + content 
            let path = SiteGeneratorEnv.baseDir + relPath
            if relPath.count > 0 {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            try htmlContent.write(to: URL(fileURLWithPath: path + fileName), atomically: false, encoding: .utf8)
            paths.append(relPath + fileName)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
}
