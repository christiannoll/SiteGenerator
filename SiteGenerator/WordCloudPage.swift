import Foundation

class WordCloudPage : Page {
    
    private let index: Index
    
    init(_ index: Index) {
        self.index = index
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(index.renderWordCloud())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
