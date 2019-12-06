import Foundation

class ArchiveMonthPage : Page {
    
    private let archiveMonth: ArchiveMonth
    
    init(_ archiveMonth: ArchiveMonth) {
        self.archiveMonth = archiveMonth
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine, newLine]
        let title = archiveMonth.monthName + " " + archiveMonth.yearName
        let h_1 = h1([.text(title)])
        mainChildren.append(h_1)
        
        let posts = archiveMonth.renderMonthPosts()
        for post: SmlNode in posts {
            mainChildren.append(post)
        }
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
