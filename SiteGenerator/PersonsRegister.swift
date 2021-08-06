import Foundation

struct PersonsRegister {
    
    private var _personsRegisterItems: [PersonsRegisterItem] = []
    
    func renderPersonsRegister() -> SmlNode {
        var divChildren: [SmlNode] = []
        
        for personsRegisterItem in _personsRegisterItems {
            let h_4 = h4([.text(personsRegisterItem.person)])
            divChildren.append(h_4)
            divChildren.append(newLine)
            divChildren.append(personsRegisterItem.renderPostListItem())
        }
        
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
    
    fileprivate mutating func sort() {
        _personsRegisterItems.sort { $0.person < $1.person }
    }
    
    fileprivate mutating func addPost(_ post: Item) {
        for personsRegisterItem in getPersonsRegisterItems(post) {
            personsRegisterItem.addPost(post)
        }
    }
    
    private mutating func getPersonsRegisterItems(_ post: Item) -> [PersonsRegisterItem] {
        var personsRegisterItems: [PersonsRegisterItem] = []
        for person in post.persons {
            var found = false
            for personsRegisterItem in _personsRegisterItems {
                if person == personsRegisterItem.person {
                    personsRegisterItems.append(personsRegisterItem)
                    found = true
                }
            }
            if !found {
                let personsRegisterItem = PersonsRegisterItem(person)
                personsRegisterItems.append(personsRegisterItem)
                _personsRegisterItems.append(personsRegisterItem)
            }
        }
        return personsRegisterItems
    }
}

struct PersonsRegisterFactory {
    public func createPersonsRegister(_ posts: [Item]) -> PersonsRegister {
        var personsRegister = PersonsRegister()
        
        for post in posts {
            personsRegister.addPost(post)
        }
        
        personsRegister.sort()
        return personsRegister
    }
}
