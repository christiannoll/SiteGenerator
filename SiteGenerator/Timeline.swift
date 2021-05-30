import Foundation

struct Timeline {
    
    private var _timelineItems: [TimelineItem] = []
    
    func reanderTimeline() -> SmlNode {
        var divChildren: [SmlNode] = []
        
        for timelineItem in _timelineItems {
            let h_4 = h4([.text(String(timelineItem.year))])
            divChildren.append(h_4)
            divChildren.append(newLine)
            divChildren.append(timelineItem.renderTimelineItem())
        }
        
        let div = div_blogArchiveIndex(divChildren)
        return div
    }
    
    fileprivate mutating func sort() {
        _timelineItems.sort { $0.year < $1.year }
    }
    
    fileprivate mutating func addPost(_ post: Item) {
        for timelineItem in getTimelineItems(post) {
            timelineItem.addPost(post)
        }
    }
    
    private mutating func getTimelineItems(_ post: Item) -> [TimelineItem] {
        var timelineItems: [TimelineItem] = []
        for year in post.years {
            var found = false
            for timelineItem in _timelineItems {
                if year == timelineItem.year {
                    timelineItems.append(timelineItem)
                    found = true
                }
            }
            if !found {
                let timelineItem = TimelineItem(year)
                timelineItems.append(timelineItem)
                _timelineItems.append(timelineItem)
            }
        }
        return timelineItems
    }
}

struct TimelineFactory {
    public func createTimeline(_ posts: [Item]) -> Timeline {
        var timeline = Timeline()
        
        for post in posts {
            timeline.addPost(post)
        }
        
        timeline.sort()
        return timeline
    }
}
