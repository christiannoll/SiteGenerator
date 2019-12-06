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

class IndexItem {
    
    private let _key: String
    private var posts: [Item] = []
    private let postBuilder = PostBuilder()
    
    var key: String {
        get { return _key }
    }
    
    init(_ key: String) {
        self._key = key
    }
    
    public func addPost(_ post: Item) {
        posts.append(post)
    }
    
    public func renderIndexItem() -> SmlNode {
        var ulChildren: [SmlNode] = [newLine]
        
        for post: Item in posts {
            var liChildren: [SmlNode] = []
            let link = postBuilder.createPostLink(post)
            liChildren.append(link)
            let l = li(liChildren)
            ulChildren.append(l)
            ulChildren.append(newLine)
        }
        
        let u = ul(ulChildren)
        return u
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
