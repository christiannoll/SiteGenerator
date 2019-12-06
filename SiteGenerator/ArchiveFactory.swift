import Foundation

class Archive {
    
    private var _years: [ArchiveYear] = []
    
    var years: [ArchiveYear] {
        get { return _years }
    }
    
    public func addPost(_ post: Item) {
        let year = getYear(post)
        year.addPost(post)
    }
    
    public func renderArchiveIndex() -> SmlNode {
        var divChildren: [SmlNode] = []
        
        for year: ArchiveYear in _years {
            let h_4 = h4([.text(year.name)])
            divChildren.append(h_4)
            divChildren.append(newLine)
            divChildren.append(year.renderMonths())
        }
        
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
    
    private func getYear(_ post: Item) -> ArchiveYear {
        for year: ArchiveYear in _years {
            let comps = Calendar.current.dateComponents([.year], from: post.date!)
            if comps.year! == year.year {
                return year
            }
        }
        return createYear(post)
    }
    
    private func createYear(_ post: Item) -> ArchiveYear {
        let comps = Calendar.current.dateComponents([.year], from: post.date!)
        let year = ArchiveYear(comps.year!)
        _years.append(year)
        return year
    }
}

class ArchiveFactory {
    
    public func createArchive(_ posts: [Item]) -> Archive {
        let archive = Archive()
        
        for post: Item in posts {
            archive.addPost(post)
        }
        
        return archive
    }
}
