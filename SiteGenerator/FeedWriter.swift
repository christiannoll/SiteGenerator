import Foundation

class FeedWriter {
    
    func writeRssFeed(_ content: String) {
        writeRssFile(content, "xml/", "rss.xml")
    }
    
    private func writeRssFile(_ content: String, _ relPath: String, _ fileName: String) {
        do {
            let xmlContent = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + content
            let path = PageWriter.baseDir + relPath
            if relPath.count > 0 {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            try xmlContent.write(to: URL(fileURLWithPath: path + fileName), atomically: false, encoding: .utf8)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
}
