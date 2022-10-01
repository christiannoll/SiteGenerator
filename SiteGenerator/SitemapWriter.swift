import Foundation

struct SitemapWriter {
    
    func writeSitemap(_ content: String) {
        writeSitemapFile(content, "sitemap/", "sitemap.txt")
    }
    
    private func writeSitemapFile(_ content: String, _ relPath: String, _ fileName: String) {
        do {
            let path = SiteGeneratorEnv.baseDir + relPath
            if relPath.count > 0 {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            try content.write(to: URL(fileURLWithPath: path + fileName), atomically: false, encoding: .utf8)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
}
