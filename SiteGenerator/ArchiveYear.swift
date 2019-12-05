import Foundation

class ArchiveYear {
    
    private var _year: Int
    private var months: [ArchiveMonth] = []
    
    var year : Int {
        get { return _year }
    }
    
    init(_ year: Int) {
        _year = year
    }
    
    public func addPost(_ post: Item) {
        let month = getMonth(post)
        month.addPost(post)
        months.append(month)
    }
    
    private func getMonth(_ post: Item) -> ArchiveMonth {
        for month: ArchiveMonth in months {
            let comps = Calendar.current.dateComponents([.month], from: post.date!)
            if comps.month! == month.month {
                return month
            }
        }
        return createMonth(post)
    }
    
    private func createMonth(_ post: Item) -> ArchiveMonth {
        let comps = Calendar.current.dateComponents([.month], from: post.date!)
        return ArchiveMonth(comps.month!)
    }
}
