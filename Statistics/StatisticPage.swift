import Foundation

class StatisticPage : Page {
    
    private var data: StatisticData
    
    init(_ data: StatisticData) {
        self.data = data
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_S = h4([.text(statisticsTitle)])
        mainChildren.append(h_S)
        mainChildren.append(newLine)
        mainChildren.append(createData())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(statisticsTitle)
    }
    
    private func createData() -> SmlNode {
        var pChildren: [SmlNode] = []
        pChildren.append(.text((SiteGeneratorEnv.forGerman() ? "Anzahl an Posts: " : "Number of posts: ") + String(data.numberOfPosts)))
        pChildren.append(br())
        pChildren.append(.text((SiteGeneratorEnv.forGerman() ? "Anzahl davon Fotos: " : "Including number of photos: ") + String(data.numberOfPhotos)))
        pChildren.append(br())
        pChildren.append(.text("Index: " + String(data.numberOfIndexItems)))
        pChildren.append(br())
        pChildren.append(.text((SiteGeneratorEnv.forGerman() ? "Kategorien: " : "Tags: ") + String(data.numberOfTagItems)))
        pChildren.append(br())
        pChildren.append(.text((SiteGeneratorEnv.forGerman() ? "Serien: " : "Serials: ") + String(data.numberOfSerialItems)))
        pChildren.append(br())
        pChildren.append(.text("Links: " + String(data.numberOfAllLinks)))
        pChildren.append(br())
        pChildren.append(br())
        pChildren.append(.text((SiteGeneratorEnv.forGerman() ? "Durchschnittliche Anzahl an Links: " : "Average number of links: ") + String(data.meanNumberOfLinks)))
        pChildren.append(br())
        pChildren.append(.text((SiteGeneratorEnv.forGerman() ? "Durchschnittliche Anzahl an Wörtern: " : "Average number of words: ") + String(data.meanNumberOfWords)))
        pChildren.append(br())
        pChildren.append(br())
        
        pChildren.append(.text((SiteGeneratorEnv.forGerman() ? "Post mit den meisten Wörtern (" : "Post with most words (") + String(data.maxWordCountPostItem?.number ?? 0) + "): "))
        pChildren.append(data.maxWordCountPostItem?.renderPostLink() ?? .text(""))
        pChildren.append(br())
        
        pChildren.append(.text((SiteGeneratorEnv.forGerman() ? "Post mit den wenigsten Wörtern (" : "Post with fewest words (") + String(data.minWordCountPostItem?.number ?? 0) + "): "))
        pChildren.append(data.minWordCountPostItem?.renderPostLink() ?? .text(""))
        pChildren.append(br())
        
        pChildren.append(.text((SiteGeneratorEnv.forGerman() ? "Post mit den meisten Links (" : "Post with most links (") + String(data.maxLinkCountPostItem?.number ?? 0) + "): "))
        pChildren.append(data.maxLinkCountPostItem?.renderPostLink() ?? .text(""))
        pChildren.append(br())
        
        return p(pChildren)
    }
}
