import Foundation

public class RssParser {
    
    private let RSS_FILE = "/Users/chn/Programmierung/Swift/SiteGenerator/vnzn/xml/rss.xml"
    
    let parser = ContentParser()
    
    public func parse() -> [Item] {
        return parser.parse(RSS_FILE)
    }
    
}
