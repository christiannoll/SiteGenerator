import Foundation

struct AppWriter {
    
    func writeLastUpdateFile() {
        writeFile(Date().ISO8601Format(), "app/", "last_update.txt")
    }
    
    private func writeFile(_ content: String, _ relPath: String, _ fileName: String) {
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
