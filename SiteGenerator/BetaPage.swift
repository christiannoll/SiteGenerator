import Foundation

class BetaPage : Page {
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(renderItems())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(metaTitle)
    }
    
    private func renderItems() -> SmlNode {
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)
        let h_4 = h4([.text(metaTitle)])
        divChildren.append(h_4)
        divChildren.append(newLine)
        
        var ulChildren: [SmlNode] = []
        
        ulChildren.append(renderItem(statisticsTitle, "statistic"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(timelineTitle, "timeline"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(personsTitle, "persons"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(moviesTitle, "movies"))
        ulChildren.append(newLine)
        
        let booksTitle = SiteGeneratorEnv.forGerman() ? "Bücher" : "Books"
        ulChildren.append(renderItem(booksTitle, "books"))
        ulChildren.append(newLine)
        
        let wordCloudTitle = SiteGeneratorEnv.forGerman() ? "Wortwolke" : "Word Cloud"
        ulChildren.append(renderItem(wordCloudTitle, "wordcloud"))
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
