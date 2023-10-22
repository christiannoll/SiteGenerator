import Foundation

class ErrorPage: Page {
    
    let errorText: String
    
    init(errorText: String) {
        self.errorText = errorText
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_I = h4([.text(errorTitle + ": " + errorText)])
        mainChildren.append(h_I)
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(errorTitle)
    }
}
