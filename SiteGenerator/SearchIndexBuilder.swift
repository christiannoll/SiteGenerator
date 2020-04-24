import Foundation

class SearchIndexBuilder {
    
    func buildIndex(_ posts: [Item]) {
        var words: [String] = []
        for post in posts {
            words.append(contentsOf: split(post.title))
            for index in post.indices {
                words.append(contentsOf: split(index))
            }
            for link in post.links {
                words.append(contentsOf: split(link.1))
            }
        }
    }
    
    private func split(_ text: String) -> [String] {
        var trimmedWords: [String] = []
        let words = text.components(separatedBy: .whitespaces)
        for word in words {
            let trimmedWord = word.trimmingCharacters(in: .punctuationCharacters)
            trimmedWords.append(trimmedWord)
        }
        return trimmedWords
    }
}
