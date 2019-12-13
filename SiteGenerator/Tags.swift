import Foundation

class Tags {
    
    private var _tagItems: [TagItem]
    
    var tagItems: [TagItem] {
        get { return _tagItems }
    }
    
    fileprivate init() {
        _tagItems = []
    }
    
    public func addPost(_ post: Item) {
        for tagItem: TagItem in getTagItems(post) {
            tagItem.addPost(post)
        }
    }
    
    private func getTagItems(_ post: Item) -> [TagItem] {
        var tagItems: [TagItem] = []
        for tag: String in post.tags {
            var found = false
            for tagItem: TagItem in _tagItems {
                if tag == tagItem.key {
                    tagItems.append(tagItem)
                    found = true
                }
            }
            if !found {
                let tagItem = TagItem(tag)
                tagItems.append(tagItem)
                _tagItems.append(tagItem)
            }
        }
        return tagItems
    }
    
    public func renderTags() -> SmlNode {
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)
        let h_4 = h4([.text("Kategorien")])
        divChildren.append(h_4)
        divChildren.append(newLine)
        
        var ulChildren: [SmlNode] = []
        
        for tagItem: TagItem in _tagItems {
            ulChildren.append(tagItem.renderTagItem())
        }
        
        let u_l = ul(ulChildren)
        divChildren.append(u_l)
        divChildren.append(newLine)
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
}

class TagsFactory {
    
    public func createTags(_ posts: [Item]) -> Tags {
        let tags = Tags()
        
        for post: Item in posts {
            tags.addPost(post)
        }
        
        return tags
    }
}