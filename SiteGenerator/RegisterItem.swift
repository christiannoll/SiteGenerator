import Foundation

class RegisterItem : PostListItem {
    
    private let _content: String
 
    init(_ content: String) {
        self._content = content
    }
    
    var content: String {
        get { return _content }
    }
}
