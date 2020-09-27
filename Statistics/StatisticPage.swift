import Foundation

class StatisticPage : Page {
    
    private var data: StatisticData
    
    init(_ data: StatisticData) {
        self.data = data
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_S = h4([.text(SiteGenerator.forGerman() ? "Statistik" : "Statistics")])
        mainChildren.append(h_S)
        mainChildren.append(newLine)
        mainChildren.append(createData())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    private func createData() -> SmlNode {
        var pChildren: [SmlNode] = []
        pChildren.append(.text((SiteGenerator.forGerman() ? "Anzahl an Posts: " : "Number of posts: ") + String(data.numberOfPosts)))
        pChildren.append(br())
        pChildren.append(.text((SiteGenerator.forGerman() ? "Anzahl davon Fotos: " : "Including number of photos: ") + String(data.numberOfPhotos)))
        pChildren.append(br())
        pChildren.append(.text("Index: " + String(data.numberOfIndexItems)))
        pChildren.append(br())
        pChildren.append(.text((SiteGenerator.forGerman() ? "Kategorien: " : "Tags: ") + String(data.numberOfTagItems)))
        pChildren.append(br())
        pChildren.append(.text((SiteGenerator.forGerman() ? "Serien: " : "Serials: ") + String(data.numberOfSerialItems)))
        pChildren.append(br())
        pChildren.append(.text("Links: " + String(data.numberOfAllLinks)))
        pChildren.append(br())
        pChildren.append(br())
        pChildren.append(.text((SiteGenerator.forGerman() ? "Durchschnittliche Anzahl an Links: " : "Average number of links: ") + String(data.meanNumberOfLinks)))
        pChildren.append(br())
        pChildren.append(.text((SiteGenerator.forGerman() ? "Durchschnittliche Anzahl an Wörtern: " : "Average number of words: ") + String(data.meanNumberOfWords)))
        pChildren.append(br())
        
        return p(pChildren)
    }
}
