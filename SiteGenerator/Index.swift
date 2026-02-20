import Foundation

class Index {
    
    private var _indexItems: [IndexItem]
    
    var indexItems: [IndexItem] {
        get { return _indexItems }
    }
    
    fileprivate init() {
        _indexItems = []
    }
    
    var numberOfIndexItems: Int {
        get { return _indexItems.count }
    }
    
    func addPost(_ post: Item) {
        for indexItem in getIndexItems(post) {
            indexItem.addPost(post)
        }
    }
    
    func sort() {
        _indexItems.sort { $0.key < $1.key }
    }
    
    func renderIndex() -> SmlNode {
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)
        let h_4 = h4([.text("Index")])
        divChildren.append(h_4)
        divChildren.append(newLine)
        
        var ulChildren: [SmlNode] = []
        
        for indexItem in _indexItems {
            ulChildren.append(indexItem.renderIndexItem())
            ulChildren.append(newLine)
        }
        
        let u_l = ul(ulChildren)
        divChildren.append(u_l)
        divChildren.append(newLine)
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
    
    func renderWordCloud() -> SmlNode {
        let headerText = SiteGeneratorEnv.forGerman() ? "Themenwolke" : "Topics Cloud"
        
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)
        let h_3 = h3([.text(headerText)])
        divChildren.append(h_3)
        divChildren.append(newLine)
        
        var pChildren: [SmlNode] = []
        
        for indexItem in _indexItems {
            if indexItem.numberOfPosts > 1 {
                pChildren.append(indexItem.renderWordCloudItem())
                pChildren.append(.text(" "))
                pChildren.append(newLine)
            }
        }
        
        let p = p(pChildren)
        divChildren.append(p)
        divChildren.append(newLine)
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
    
    private func getIndexItems(_ post: Item) -> [IndexItem] {
        var indexItems: [IndexItem] = []
        for index in post.indices {
            var found = false
            for indexItem in _indexItems {
                if index == indexItem.key {
                    indexItems.append(indexItem)
                    found = true
                }
            }
            if !found {
                let indexItem = IndexItem(index)
                indexItems.append(indexItem)
                _indexItems.append(indexItem)
            }
        }
        return indexItems
    }
}

class IndexFactory {
    
    func createIndex(_ posts: [Item]) -> Index {
        let index = Index()
        
        for post in posts {
            index.addPost(post)
        }
        
        index.sort()
        return index
    }
}
