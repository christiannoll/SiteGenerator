import Foundation

class BooksRegisterPage : Page {
    
    private let booksRegister: BooksRegister
    
    init(_ booksRegister: BooksRegister) {
        self.booksRegister = booksRegister
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        
        mainChildren.append(booksRegister.renderBooksRegister())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(booksTitle)
    }
}
