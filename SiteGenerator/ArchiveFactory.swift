import Foundation

class Archive {
    
    private var years: [ArchiveYear] = []
    
    public func addPost(_ post: Item) {
        let year = getYear(post)
        year.addPost(post)
        years.append(year)
    }
    
    private func getYear(_ post: Item) -> ArchiveYear {
        for year: ArchiveYear in years {
            let comps = Calendar.current.dateComponents([.year], from: post.date!)
            if comps.year! == year.year {
                return year
            }
        }
        return createYear(post)
    }
    
    private func createYear(_ post: Item) -> ArchiveYear {
        let comps = Calendar.current.dateComponents([.year], from: post.date!)
        return ArchiveYear(comps.year!)
    }
}

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

class ArchiveMonth {
    
    private var _month: Int
    private var posts: [Item] = []
    
    var month: Int {
        get { return _month }
    }
    
    init(_ month: Int) {
        self._month = month
    }
    
    public func addPost(_ post: Item) {
        posts.append(post)
    }
}


class ArchiveFactory {
    
    public func createArchive(_ posts: [Item]) -> Archive{
        let archive = Archive()
        
        for post: Item in posts {
            archive.addPost(post)
        }
        
        return archive
    }
}
