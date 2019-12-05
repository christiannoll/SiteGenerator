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

class ArchiveFactory {
    
    public func createArchive(_ posts: [Item]) -> Archive{
        let archive = Archive()
        
        for post: Item in posts {
            archive.addPost(post)
        }
        
        return archive
    }
}
