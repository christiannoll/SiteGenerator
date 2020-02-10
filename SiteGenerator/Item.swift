import Foundation

class Item  {
    var data = ""
    var name = ""
    var title = ""
    var date: Date?
    var tags: Set<String> = []
    var indices: Set<String> = []
    var serial = ""
    
    let smlBuilder = PostBuilder()
    
    func renderPost() -> SmlNode {return .text("")}
    func renderPostInSingleMode() -> SmlNode { return renderPost() }
}

class TextPost: Item {
    var format = "normal"
    
    override func renderPost() -> SmlNode {
        return smlBuilder.createTextArticle(self)
    }
}

class ImagePost : Item {
    var width = 250
    var height = 250
    
    override func renderPost() -> SmlNode {
        return smlBuilder.createImageArticle(self)
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
