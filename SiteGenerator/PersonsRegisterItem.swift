import Foundation

class PersonsRegisterItem : PostListItem {
    
    private let _person: String
 
    init(_ person: String) {
        self._person = person
    }
    
    var person: String {
        get { return _person }
    }
}
