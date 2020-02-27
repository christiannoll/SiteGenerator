import Foundation

class FtpScriptWriter {
    
    private let baseUrl = URL(fileURLWithPath: PageWriter.baseDir)
    private let folderNames = ["2019", "2020", "archive", "images", "impressum", "index", "statistic", "tags", "serials", "xml"]
    
    private var script = ""
    
    init() {
        script.append("cd public_html\n")
        generateDeleteCommands()
    }
    
    func writeScript() {
        generateMkdirCommands()
        generatePutCommands()
        writeScriptFile(script)
    }
    
    private func generateDeleteCommands() {
        script.append("rm index.html\n")
        
        for folderName in folderNames {
            let files = getFolderContent(folderName, false)
            files.forEach { script.append("rm " + $0 + "\n") }
        }
        
        for folderName in folderNames {
            var dirs = getFolderContent(folderName, true)
            dirs.reverse()
            dirs.append(folderName)
            dirs.forEach { script.append("rmdir " + $0 + "\n") }
        }
    }
    
    private func generateMkdirCommands() {
        for folderName in folderNames {
            var dirs = getFolderContent(folderName, true)
            dirs.insert(folderName, at: 0)
            dirs.forEach { script.append("mkdir " + $0 + "\n") }
        }
    }
    
    private func generatePutCommands() {
        script.append("put index.html\n")
        script.append("put styles.css\n")
        
        for folderName in folderNames {
            let files = getFolderContent(folderName, false)
            files.forEach { script.append("put " + $0 + " " + $0 + "\n") }
        }
        script.append("bye")
    }
    
    private func getFolderContent(_ folderName: String, _ onlyFolder: Bool) -> [String] {
        let fm = FileManager.default
        let path = PageWriter.baseDir + folderName
        
        var items = [String]()
        
        let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])
        let directoryURL = URL(string: path)
        let directoryEnumerator = fm.enumerator(at: directoryURL!, includingPropertiesForKeys: Array(resourceKeys), options: .skipsHiddenFiles)!
        
        while case let fileUrl as URL = directoryEnumerator.nextObject() {
            if onlyFolder && fileUrl.hasDirectoryPath {
                items.append(fileUrl.relativePath(from: baseUrl)!)
            }
            else if !onlyFolder && !fileUrl.hasDirectoryPath {
                items.append(fileUrl.relativePath(from: baseUrl)!)
            }
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
