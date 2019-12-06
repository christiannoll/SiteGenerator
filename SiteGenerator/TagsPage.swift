import Foundation

class TagsPage : Page {
    
    private let tags: Tags
    
    init(_ tags: Tags) {
        self.tags = tags
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(tags.renderTags())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
