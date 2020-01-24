import Foundation

class FtpScriptWriter {
    
    private let folderNames = ["2019", "2020", "archive", "images", "impressum", "index", "statistic", "tags"]
    
    func writeScript() {
        var content = ""
        for folderName in folderNames {
            let items = getFolderContent(folderName)
            items.forEach { content.append($0 + "\n") }
        }
        writeScriptFile(content)
    }
    
    private func getFolderContent(_ folderName: String) -> [String] {
        let fm = FileManager.default
        let path = PageWriter.baseDir + folderName
        
        var items = [String]()
        
        let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])
        let directoryURL = URL(string: path)
        let directoryEnumerator = fm.enumerator(at: directoryURL!, includingPropertiesForKeys: Array(resourceKeys), options: .skipsHiddenFiles)!
        let baseUrl = URL(fileURLWithPath: PageWriter.baseDir)
        while case let fileUrl as URL = directoryEnumerator.nextObject() {
            //if (!fileUrl.hasDirectoryPath) {
                items.append(fileUrl.relativePath(from: baseUrl)!)
            //}
        }
                
        return items
    }
    
    private func writeScriptFile(_ content: String) {
        do {
            let fileName = "sftpScript.txt"
            let relPath = "ftp/"
            let path = PageWriter.baseDir + relPath
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

extension URL {
    func relativePath(from base: URL) -> String? {
        // Ensure that both URLs represent files:
        guard self.isFileURL && base.isFileURL else {
            return nil
        }
        
        // Remove/replace "." and "..", make paths absolute:
        let destComponents = self.standardized.pathComponents
        let baseComponents = base.standardized.pathComponents
        
        // Find number of common path components:
        var i = 0
        while i < destComponents.count && i < baseComponents.count
            && destComponents[i] == baseComponents[i] {
                i += 1
        }
        
        // Build relative path:
        var relComponents = Array(repeating: "..", count: baseComponents.count - i)
        relComponents.append(contentsOf: destComponents[i...])
        return relComponents.joined(separator: "/")
    }
}
