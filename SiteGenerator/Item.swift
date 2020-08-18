import Foundation

public class Item  {
    let id: Int
    var data = ""
    var name = ""
    var title = ""
    var date: Date?
    var tags: Set<String> = []
    var indices: Set<String> = []
    var serial = ""
    var links: [String: String] = [:]
    
    let smlBuilder = PostBuilder()
    
    init(_ id: Int) {
        self.id = id
    }
    
    func renderUrlTitle() -> SmlNode {return .text(title)}
    
    func renderPost() -> SmlNode {return .text("")}
    func renderPostInSingleMode() -> SmlNode { return renderPost() }
    
    func renderRss() -> SmlNode { return .text("") }
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
        let prefix = SiteGenerator.forGerman() ? "Foto: " : "Photo: "
        return .text(prefix + title)
    }
    
    override func renderPost() -> SmlNode {
        return smlBuilder.createImageArticle(self)
    }
    
    override func renderRss() -> SmlNode {
        return smlBuilder.createRssImageArticle(self)
    }
    
    override func renderPostInSingleMode() -> SmlNode {
        let origWidth = width
        let origHeight = height
        width = 300
        height = 300
        
        let post = renderPost()
        
        width = origWidth
        height = origHeight
        return post
    }
}
