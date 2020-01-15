import Foundation

class ArchiveYear {
    
    private var _year: Int
    private var _months: [ArchiveMonth] = []
    
    var year: Int {
        get { return _year }
    }
    
    var name: String {
        get { return String(_year) }
    }
    
    var months: [ArchiveMonth] {
        get { return _months }
    }
    
    init(_ year: Int) {
        _year = year
    }
    
    public func addPost(_ post: Item) {
        let month = getMonth(post)
        month.addPost(post)
    }
    
    public func renderMonths() -> SmlNode {
        if _months.count > 0 {
            var ulChildren: [SmlNode] = []
            
            for month in _months {
                ulChildren.append(month.renderMonth())
                ulChildren.append(newLine)
            }
            
            let u = ul(ulChildren)
            return u
        }
        else {
            return .text("")
        }
    }
    
    private func getMonth(_ post: Item) -> ArchiveMonth {
        for month in _months {
            let comps = Calendar.current.dateComponents([.month], from: post.date!)
            if comps.month! == month.month {
                return month
            }
        }
        return createMonth(post)
    }
    
    private func createMonth(_ post: Item) -> ArchiveMonth {
        let comps = Calendar.current.dateComponents([.month], from: post.date!)
        let month = ArchiveMonth(comps.month!, _year)
        _months.append(month)
        return month
    }
}
