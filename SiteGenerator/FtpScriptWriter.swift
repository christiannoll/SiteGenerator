import Foundation

class FtpScriptWriter {
    
    let fileNames: [String]
    
    init(_ fileNames: [String]) {
        self.fileNames = fileNames
    }
    
    func writeScript() {
        var content = ""
        for name in fileNames {
            content.append(name)
            content.append("\n")
        }
        
        writeScriptFile(content)
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
