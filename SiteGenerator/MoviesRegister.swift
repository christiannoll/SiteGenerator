import Foundation

struct MoviesRegister {

    private var register = Register()
    
    func renderMoviesRegister() -> SmlNode {
        register.renderRegister()
    }
    
    fileprivate mutating func sort() {
        register.sort()
    }
    
    fileprivate mutating func addPost(_ post: Item) {
        for moviesRegisterItem in register.getRegisterItems(post.movies) {
            moviesRegisterItem.addPost(post)
        }
    }
}

struct MoviesRegisterFactory {
    public func createMoviesRegister(_ posts: [Item]) -> MoviesRegister {
        var moviesRegister = MoviesRegister()
        
        for post in posts {
            moviesRegister.addPost(post)
        }
        
        moviesRegister.sort()
        return moviesRegister
    }
}
