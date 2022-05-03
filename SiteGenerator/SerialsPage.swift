import Foundation

class SerialsPage : Page {
    
    private let serials: Serials
    
    init(_ serials: Serials) {
        self.serials = serials
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(serials.renderTags())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(serialsTitle)
    }
}
