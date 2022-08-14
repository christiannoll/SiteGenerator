import Foundation

class BetaPage : Page {
    
    var title: String {
        get { metaTitle }
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(renderItems())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(metaTitle)
    }
    
    func getListItems() -> [SmlNode] {
        var ulChildren: [SmlNode] = []
        
        ulChildren.append(renderItem(statisticsTitle, "statistic"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(timelineTitle, "timeline"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(personsTitle, "persons"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(moviesTitle, "movies"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(booksTitle, "books"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(photosTitle, "tags/" + TagItemPage.photoKey))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(wordCloudTitle, "wordcloud"))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(storiesTitle, "tags/" + TagItemPage.storyKey))
        ulChildren.append(newLine)
        
        ulChildren.append(renderItem(experimentsTitle + " 🔬", "experiments"))
        ulChildren.append(newLine)
        
        return ulChildren
    }
    
    private func renderItems() -> SmlNode {
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)
        let h_4 = h4([.text(title)])
        divChildren.append(h_4)
        divChildren.append(newLine)
        
        let u_l = ul(getListItems())
        divChildren.append(u_l)
        divChildren.append(newLine)
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
    
    func renderItem(_ title: String, _ relPath: String) -> SmlNode {
        var liChildren: [SmlNode] = []
        let link = a([href => (Page.baseUrl + relPath + "/")], [.text(title)])
        liChildren.append(link)
        let l = li(liChildren)
        return l
    }
}
