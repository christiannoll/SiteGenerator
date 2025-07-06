import Foundation

public enum ItemType {
    case text
    case image
}

public class Item {
    let id: Int
    var data = ""
    var name = ""
    var title = ""
    var date: Date?
    var tags: Set<String> = []
    var indices: Set<String> = []
    var serials: Set<String> = []
    var links: [String: String] = [:]
    var years: [Int] = []
    var persons: Set<String> = []
    var movies: Set<String> = []
    var books: Set<String> = []

    var inSingleMode = false

    let smlBuilder = PostBuilder()
    
    init(_ id: Int) {
        self.id = id
    }
    
    func renderUrlTitle() -> SmlNode {return .text(title)}
    
    func renderPost() -> SmlNode {return .text("")}

    func renderArtPost() -> SmlNode {return .text("")}

    func renderPostInSingleMode() -> SmlNode {
        inSingleMode = true
        let post = renderPost()
        inSingleMode = false
        return post
    }

    func renderRss() -> SmlNode { return .text("") }
    
    func itemType() -> ItemType { return .text }
}

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
}

class TextPost: Item {
    var format = "normal"
    
    override func renderPost() -> SmlNode {
        return smlBuilder.createTextArticle(self)
    }
    
    override func renderRss() -> SmlNode {
        return smlBuilder.createRssTextArticle(self)
    }
}

class ImagePost : Item {
    var width = 250
    var height = 250
    
    override func renderUrlTitle() -> SmlNode {
        let prefix = SiteGeneratorEnv.forGerman() ? "Bild: " : "Image: "
        return .text(prefix + title)
    }
    
    override func renderPost() -> SmlNode {
        return smlBuilder.createImageArticle(self)
    }

    override func renderArtPost() -> SmlNode {
        return smlBuilder.createImageArt(self)
    }

    override func renderRss() -> SmlNode {
        return smlBuilder.createRssImageArticle(self)
    }
    
    override func renderPostInSingleMode() -> SmlNode {
        let origWidth = width
        let origHeight = height
        width = 300
        height = 300

        inSingleMode = true
        let post = renderPost()
        inSingleMode = false

        width = origWidth
        height = origHeight
        return post
    }
    
    override func itemType() -> ItemType {
        .image
    }
}
