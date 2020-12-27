import Foundation

struct RandomEntriesBuilder {
    
    func writeJsFile(_ posts: [Item]) {
        do {
            let relPath = "random/"
            let content = generateJsCode(posts)
            let path = SiteGeneratorEnv.baseDir + relPath
            if relPath.count > 0 {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            try content.write(to: URL(fileURLWithPath: path + "entries.js"), atomically: false, encoding: .utf8)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    private func generateJsCode(_ posts: [Item]) -> String {
        var jsCode = "let entries = [\n"
        
        for post in posts {
            jsCode += "'"
            jsCode += PostBuilder.createPostUrl(post)
            jsCode += "',\n"
        }
        
        jsCode = jsCode.trimmingCharacters(in: .delimiters)
        jsCode += "];\n"
        
        return jsCode
    }
}
