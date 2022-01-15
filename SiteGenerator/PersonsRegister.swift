import Foundation

struct PersonsRegister {

    private var register = Register()
    
    func renderPersonsRegister() -> SmlNode {
        register.renderRegister()
    }
    
    fileprivate mutating func sort() {
        register.sort()
    }
    
    fileprivate mutating func addPost(_ post: Item) {
        for personsRegisterItem in register.getRegisterItems(post.persons) {
            personsRegisterItem.addPost(post)
        }
    }
}

struct PersonsRegisterFactory {
    public func createPersonsRegister(_ posts: [Item]) -> PersonsRegister {
        var personsRegister = PersonsRegister()
        
        for post in posts {
            personsRegister.addPost(post)
        }
        
        personsRegister.sort()
        return personsRegister
    }
}
