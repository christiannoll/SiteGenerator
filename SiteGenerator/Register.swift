import Foundation

struct Register {
    
    private var registerItems: [RegisterItem] = []
    
    func renderRegister() -> SmlNode {
        var divChildren: [SmlNode] = []
        
        for registerItem in registerItems {
            let h_4 = h4([.text(registerItem.content)], 
                         idString: registerItem.content.convertToUrlPath())
            divChildren.append(h_4)
            divChildren.append(newLine)
            divChildren.append(registerItem.renderPostListItem())
        }
        
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
    
    func renderRegisterCloud(headerText: String) -> SmlNode {
        var divChildren: [SmlNode] = []
        divChildren.append(newLine)
        let h_3 = h3([.text(headerText)])
        divChildren.append(h_3)
        divChildren.append(newLine)
        
        var pChildren: [SmlNode] = []
        
        for registerItem in registerItems {
            if registerItem.numberOfPosts > 1 {
                pChildren.append(registerItem.renderRegisterCloudItem())
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
    
    mutating func sort() {
        registerItems.sort { $0.content < $1.content }
    }
    
    mutating func getRegisterItems(_ postRegisterItems: Set<String>) -> [RegisterItem] {
        var _registerItems: [RegisterItem] = []
        for postRegisterItem in postRegisterItems {
            var found = false
            for registerItem in registerItems {
                if postRegisterItem == registerItem.content {
                    _registerItems.append(registerItem)
                    found = true
                }
            }
            if !found {
                let registerItem = RegisterItem(postRegisterItem)
                registerItems.append(registerItem)
                _registerItems.append(registerItem)
            }
        }
        return _registerItems
    }
}
