import Foundation

class BetaPage : Page {
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(renderItems())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    private func renderItems() -> SmlNode {
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)
        let h_4 = h4([.text("Beta")])
        divChildren.append(h_4)
        divChildren.append(newLine)
        
        var ulChildren: [SmlNode] = []
        
        let statisticsTitle = SiteGeneratorEnv.forGerman() ? "Statistik" : "Statistics"
        ulChildren.append(renderItem(statisticsTitle, "statistic"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem("Timeline", "timeline"))
        ulChildren.append(newLine)
        
        let u_l = ul(ulChildren)
        divChildren.append(u_l)
        divChildren.append(newLine)
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
    
    private func renderItem(_ title: String, _ relPath: String) -> SmlNode {
        var liChildren: [SmlNode] = []
        let link = a([href => (Page.baseUrl + relPath + "/")], [.text(title)])
        liChildren.append(link)
        let l = li(liChildren)
        return l
    }
}