import Foundation

protocol PostItem {
    func renderPost() -> String
}

class Item : PostItem {
    var data = ""
    var name = ""
    var title = ""
    var date: Date?
    var tags : Set<String> = []
    var indices : Set<String> = []
    
    let smlBuilder = SmlBuilder()
    
    func renderPost() -> String {return ""}
}

class TextPost: Item {
    override func renderPost() -> String {
        return smlBuilder.createTextArticle(self).render()
    }
}

class ImagePost : Item {
    var width = 250
    var height = 250
    
    override func renderPost() -> String {
        return smlBuilder.createImageArticle(self).render()
    }
}
