import Foundation

class MoviesRegisterPage : Page {
    
    private let moviesRegister: MoviesRegister
    
    init(_ moviesRegister: MoviesRegister) {
        self.moviesRegister = moviesRegister
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_title = h3([.text(moviesTitle)])
        mainChildren.append(h_title)
        mainChildren.append(newLine)
        mainChildren.append(moviesRegister.renderMoviesRegister())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(moviesTitle)
    }
}
