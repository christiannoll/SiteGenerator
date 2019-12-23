import Foundation

class StatisticPage : Page {
    
    private var data: StatisticData
    
    init(_ data: StatisticData) {
        self.data = data
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_S = h4([.text("Statistik")])
        mainChildren.append(h_S)
        mainChildren.append(newLine)
        mainChildren.append(createData())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    private func createData() -> SmlNode {
        var pChildren: [SmlNode] = []
        pChildren.append(.text("Anzahl an Posts: " + String(data.numberOfPosts)))
        pChildren.append(br())
        pChildren.append(.text("Anzahl davon Fotos: " + String(data.numberOfPhotos)))
        pChildren.append(br())
        pChildren.append(.text("Anzahl an Indices: " + String(data.numberOfIndexItems)))
        pChildren.append(br())
        pChildren.append(.text("Anzahl an Kategorien: " + String(data.numberOfTagItems)))
        pChildren.append(br())
        
        return p(pChildren)
    }
}
