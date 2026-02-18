import Foundation

class BooksRegisterPage : Page {
    
    private let booksRegister: BooksRegister
    
    init(_ booksRegister: BooksRegister) {
        self.booksRegister = booksRegister
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_title = h3([.text(booksTitle)])
        mainChildren.append(h_title)
        mainChildren.append(newLine)
        mainChildren.append(booksRegister.renderBooksRegister())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(booksTitle)
    }
}
