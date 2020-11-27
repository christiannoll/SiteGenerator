import Foundation

struct SearchIndexBuilder {
    
    private var searchIndex = [String: Set<Int>]()
    
    mutating func buildIndex(_ posts: [Item]) {
        for post in posts {
            var words: [String] = []
            
            words.append(contentsOf: split(post.title))
            words.append(contentsOf: post.indices.map(split).joined())
            words.append(contentsOf: post.tags.map(split).joined())
            words.append(contentsOf: post.links.map { split($0.1) }.joined())
            
            for word in words {
                let upperBound = word.count-2
                for index in 0..<upperBound {
                    let start = word.index(word.startIndex, offsetBy: index)
                    let end = word.index(start, offsetBy: +3)
                    let range = start..<end
                    let part = String(word[range])
                    if var postIndices = searchIndex[part] {
                        postIndices.insert(post.id)
                        searchIndex[part] = postIndices
                    }
                    else {
                        searchIndex[part] = Set<Int>([post.id])
                    }
                }
            }
        }
    }
    
    func writeJsFile() {
        do {
            let relPath = "search/"
            let content = generateJsCode()
            let path = SiteGeneratorEnv.baseDir + relPath
            if relPath.count > 0 {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            try content.write(to: URL(fileURLWithPath: path + "searchIndex.js"), atomically: false, encoding: .utf8)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    private func generateJsCode() -> String {
        var jsCode = "function getSearchIndex() {\n"
        jsCode += "var map = new Map(["
        
        var first = true
        
        for (part, indices) in searchIndex {
            if !first {
                jsCode += ","//\n"
            }
            
            jsCode += "[\""
            jsCode += part
            jsCode += "\", ["
            
            for (idx, element) in indices.enumerated() {
                jsCode += String(element)
                if idx != indices.count - 1 {
                    jsCode += ","
                }
                // https://www.geeksforgeeks.org/map-in-javascript/
            }
            jsCode += "]]"
            
            if first {
                first = false
            }
        }
        
        jsCode += "]);\n"
        jsCode += "return map}"
        
        return jsCode
    }
    
    private func split(_ text: String) -> [String] {
        var trimmedWords: [String] = []
        let words = text.components(separatedBy: .whitespaces)
        for word in words {
            let trimmedWord = word.trimmingCharacters(in: .punctuationCharacters)
            if trimmedWord.count > 2 {
                trimmedWords.append(trimmedWord.lowercased())
            }
        }
        return trimmedWords
    }
}
