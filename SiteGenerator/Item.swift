import Foundation

protocol PostItem {
    func generatePost()
}

class Item : PostItem {
    var data = ""
    var name = ""
    var title = ""
    var date: Date?
    var tags : Set<String> = []
    var indices : Set<String> = []
    
    func generatePost() {}
}

class TextPost: Item {
    override func generatePost() {
    }
}

class ImagePost : Item {
    var width = 250
    var height = 250
    
    override func generatePost() {
    }
}
