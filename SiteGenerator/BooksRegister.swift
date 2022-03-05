import Foundation

struct BooksRegister {

    private var register = Register()
    
    func renderBooksRegister() -> SmlNode {
        register.renderRegister()
    }
    
    fileprivate mutating func sort() {
        register.sort()
    }
    
    fileprivate mutating func addPost(_ post: Item) {
        for booksRegisterItem in register.getRegisterItems(post.books) {
            booksRegisterItem.addPost(post)
        }
    }
}

struct BooksRegisterFactory {
    public func createBooksRegister(_ posts: [Item]) -> BooksRegister {
        var booksRegister = BooksRegister()
        
        for post in posts {
            booksRegister.addPost(post)
        }
        
        booksRegister.sort()
        return booksRegister
    }
}
