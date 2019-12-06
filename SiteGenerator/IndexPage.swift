import Foundation

class IndexPage : Page {
    
    private let index: Index
    
    init(_ index: Index) {
        self.index = index
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(index.renderIndex())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
