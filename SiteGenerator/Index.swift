import Foundation

class Index {
    
    private var _indexItems: [IndexItem]
    
    fileprivate init() {
        _indexItems = []
    }
    
    public func addPost(_ post: Item) {
        for indexItem: IndexItem in getIndexItems(post) {
            indexItem.addPost(post)
        }
    }
    
    public func renderIndex() -> SmlNode {
        var divChildren: [SmlNode] = []
        
        for indexItem: IndexItem in _indexItems {
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
            for indexItem: IndexItem in _indexItems {
                if index == indexItem.key {
                    indexItems.append(indexItem)
                }
            }
            if indexItems.count == 0 {
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
        
        return index
    }
}
