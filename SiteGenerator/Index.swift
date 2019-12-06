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
        
        /*for year: ArchiveYear in _years {
            let h_4 = h4([.text(year.name)])
            divChildren.append(h_4)
            divChildren.append(newLine)
            divChildren.append(year.renderMonths())
        }*/
        
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
                indexItems.append(IndexItem(index))
            }
        }
        return indexItems
    }
}

class IndexItem {
    
    private let _key: String
    private var posts: [Item] = []
    
    var key: String {
        get { return _key }
    }
    
    init(_ key: String) {
        self._key = key
    }
    
    public func addPost(_ post: Item) {
        posts.append(post)
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
