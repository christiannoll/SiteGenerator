import Foundation

class TimelinePage : Page {
    
    private let timeline: Timeline
    
    init(_ timeline: Timeline) {
        self.timeline = timeline
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_title = h3([.text(timelineTitle)])
        mainChildren.append(h_title)
        mainChildren.append(newLine)
        mainChildren.append(timeline.reanderTimeline())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(timelineTitle)
    }
}
