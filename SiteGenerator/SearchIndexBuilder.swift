import Foundation

struct SearchIndexBuilder {
    
    func buildIndex(_ posts: [Item]) {
        var searchIndex = [String: Set<Int>]()
        var words: [String] = []
        
        for post in posts {
            words.append(contentsOf: split(post.title))
            words.append(contentsOf: post.indices.map { split($0) }.joined())
            words.append(contentsOf: post.tags.map { split($0) }.joined())
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
                    }
                    else {
                        searchIndex[part] = Set<Int>([post.id])
                    }
                }
            }
        }
    }
    
    private func split(_ text: String) -> [String] {
        var trimmedWords: [String] = []
        let words = text.components(separatedBy: .whitespaces)
        for word in words {
            let trimmedWord = word.trimmingCharacters(in: .punctuationCharacters)
            if trimmedWord.count > 2 {
                trimmedWords.append(trimmedWord)
            }
        }
        return trimmedWords
    }
}
