import Foundation

class PageWriter {
    
    static let baseDir = "/Users/chn/Programmierung/Swift/SiteGenerator/vnzn/"
    
    private var _generatedFileNames: [String] = []
    
    var generatedFileNames: [String] {
        get { return _generatedFileNames }
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
    
    public func writeTagItemPage(_ tagItem: TagItem, _ content: String) {
        let relPath = "tags/" + tagItem.key.convertToUrlPath() + "/"
        writeHtmlFile(content, relPath, "index.html")
    }
    
    public func writeImpressumPage(_ content: String) {
        writeHtmlFile(content, "impressum/", "index.html")
    }
    
    public func writeStatisticPage(_ content: String) {
        writeHtmlFile(content, "statistic/", "index.html")
    }
    
    private func writeHtmlFile(_ content: String, _ relPath: String, _ fileName: String) {
        do {
            let htmlContent = "<!DOCTYPE html>\n" + content 
            let path = PageWriter.baseDir + relPath
            if relPath.count > 0 {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            try htmlContent.write(to: URL(fileURLWithPath: path + fileName), atomically: false, encoding: .utf8)
            _generatedFileNames.append(relPath + fileName)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
}
