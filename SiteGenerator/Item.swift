import Foundation

protocol PostItem {
    func renderPost() -> SmlNode
}

class Item : PostItem {
    var data = ""
    var name = ""
    var title = ""
    var date: Date?
    var tags : Set<String> = []
    var indices : Set<String> = []
    
    let smlBuilder = SmlBuilder()
    
    func renderPost() -> SmlNode {return .text("")}
}

class TextPost: Item {
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
}
