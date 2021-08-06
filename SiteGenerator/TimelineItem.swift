import Foundation

class TimelineItem : PostListItem {
    
    private let _year: Int
 
    init(_ year: Int) {
        self._year = year
    }
    
    var year: Int {
        get { return _year }
    }
}
