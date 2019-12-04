import Foundation

class PageWriter {
    
    private let baseDir = "/Users/chn/Programmierung/Swift/SiteGenerator/vnzn/"
    
    public func writeHomePage(_ content: String) {
        writeHtmlFile(content, "index.html")
    }
    
    public func writePostPage(_ item: Item, _ content: String) {
        
    }
    
    private func writeHtmlFile(_ content: String, _ relPath: String) {
        do {
            let htmlContent = content + "<!DOCTYPE html>\n"
            try htmlContent.write(to: URL(fileURLWithPath: baseDir + relPath), atomically: false, encoding: .utf8)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
}
