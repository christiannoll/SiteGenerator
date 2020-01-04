import Foundation

class Index {
    
    private var _indexItems: [IndexItem]
    
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
        
        for indexItem in _indexItems {
            divChildren.append(newLine)
            let h_4 = h4([.text(indexItem.key)])
            divChildren.append(h_4)
            divChildren.append(newLine)
            divChildren.append(indexItem.renderIndexItem())
        }
        
        divChildren.append(newLine)
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
    
    private func getIndexItems(_ post: Item) -> [IndexItem] {
        var indexItems: [IndexItem] = []
        for index: String in post.indices {
            var found = false
            for indexItem: IndexItem in _indexItems {
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
    
    public func createIndex(_ posts: [Item]) -> Index {
        let index = Index()
        
        for post: Item in posts {
            index.addPost(post)
        }
        
        index.sort()
        return index
    }
}
