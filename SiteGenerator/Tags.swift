import Foundation

class Tags {
    
    fileprivate var _tagItems: [TagItem]
    fileprivate var headerText = "Kategorien"
    
    var tagItems: [TagItem] {
        get { return _tagItems }
    }
    
    var numberOfTagItems: Int {
        get { return _tagItems.count }
    }
    
    fileprivate init() {
        _tagItems = []
    }
    
    func sort() {
        _tagItems.sort { $0.key < $1.key }
    }
    
    func addPost(_ post: Item) {
        for tagItem in getTagItems(post) {
            tagItem.addPost(post)
        }
    }
    
    fileprivate func getTagItems(_ post: Item) -> [TagItem] {
        var tagItems: [TagItem] = []
        for tag in post.tags {
            var found = false
            for tagItem in _tagItems {
                if tag == tagItem.key {
                    tagItems.append(tagItem)
                    found = true
                }
            }
            if !found {
                let tagItem = TagItem(tag, "tags/")
                tagItems.append(tagItem)
                _tagItems.append(tagItem)
            }
        }
        return tagItems
    }
    
    func renderTags() -> SmlNode {
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)
        let h_4 = h4([.text(headerText)])
        divChildren.append(h_4)
        divChildren.append(newLine)
        
        var ulChildren: [SmlNode] = []
        
        for tagItem in _tagItems {
            ulChildren.append(tagItem.renderTagItem())
            ulChildren.append(newLine)
        }
        
        let u_l = ul(ulChildren)
        divChildren.append(u_l)
        divChildren.append(newLine)
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
}

class TagsFactory {
    
    func createTags(_ posts: [Item]) -> Tags {
        let tags = Tags()
        
        for post in posts {
            tags.addPost(post)
        }
        
        tags.sort()
        return tags
    }
}

class Serials : Tags {
    
    fileprivate override func getTagItems(_ post: Item) -> [TagItem] {
        var tagItems: [TagItem] = []
        let tag = post.serial
        if tag.count > 0 {
            var found = false
            for tagItem in _tagItems {
                if tag == tagItem.key {
                    tagItems.append(tagItem)
                    found = true
                }
            }
            if !found {
                let tagItem = TagItem(tag, "serials/")
                tagItems.append(tagItem)
                _tagItems.append(tagItem)
            }
        }
        return tagItems
    }
}

class SerialsFactory {
    
    func createSerials(_ posts: [Item]) -> Serials {
        let serials = Serials()
        serials.headerText = "Serien"
        
        for post in posts {
            serials.addPost(post)
        }
        
        serials.sort()
        return serials
    }
}
