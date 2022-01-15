import Foundation

struct Register {
    
    private var registerItems: [RegisterItem] = []
    
    func renderRegister() -> SmlNode {
        var divChildren: [SmlNode] = []
        
        for registerItem in registerItems {
            let h_4 = h4([.text(registerItem.content)])
            divChildren.append(h_4)
            divChildren.append(newLine)
            divChildren.append(registerItem.renderPostListItem())
        }
        
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
