import Foundation

class ArchivePage : Page {
    
    private let archive: Archive
    
    init(_ archive: Archive) {
        self.archive = archive
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(archive.renderArchiveIndex())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
