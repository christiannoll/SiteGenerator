import Foundation

class SearchItems {
    
    fileprivate var _searchItems: [SearchItem]
    
    var searchItems: [SearchItem] {
        get { return _searchItems }
    }
    
    fileprivate init() {
        _searchItems = []
    }
    
    func addPost(_ post: Item) {
        _searchItems.append(SearchItem(post))
    }
    
    func renderSearchItems() -> SmlNode {
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)
        let h_4 = h4([.text(SiteGeneratorEnv.forGerman() ? "Einträge" : "Posts")])
        divChildren.append(h_4)
        divChildren.append(newLine)
        
        var ulChildren: [SmlNode] = []
        
        for searchItem in _searchItems {
            ulChildren.append(searchItem.renderSearchItem())
            ulChildren.append(newLine)
        }
        
        let u_l = ul(ulChildren)
        divChildren.append(u_l)
        divChildren.append(newLine)
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
}

struct SearchItemsFactory {
    public func createSearchItems(_ posts: [Item]) -> SearchItems {
        let searchItems = SearchItems()
        
        for post in posts {
            searchItems.addPost(post)
        }
        return searchItems
    }
}
