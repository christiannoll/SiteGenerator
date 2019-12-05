import Foundation

class PageWriter {
    
    private let baseDir = "/Users/chn/Programmierung/Swift/SiteGenerator/vnzn/"
    
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
    
    private func writeHtmlFile(_ content: String, _ relPath: String, _ fileName: String) {
        do {
            let htmlContent = content + "<!DOCTYPE html>\n"
            let path = baseDir + relPath
            if relPath.count > 0 {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            try htmlContent.write(to: URL(fileURLWithPath: path + fileName), atomically: false, encoding: .utf8)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
}