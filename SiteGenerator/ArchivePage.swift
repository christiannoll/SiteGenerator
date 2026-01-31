import Foundation

class ArchivePage : Page {
    
    private let archive: Archive
    
    init(_ archive: Archive) {
        self.archive = archive
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(renderMaxLink())
        mainChildren.append(newLine)
        mainChildren.append(archive.renderArchiveIndex())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }

    func renderMaxLink() -> SmlNode {
        let link = a([href => (Page.baseUrl + "max/")], [SiteGeneratorEnv.forGerman() ? "Ein langer Strom": "A Long Stream"])
        let para = p([link])
        return para
    }
}
