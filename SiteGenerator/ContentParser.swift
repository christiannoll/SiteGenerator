import Foundation

class ContentParser : NSObject, XMLParserDelegate {
    
    private let CONTENT_FILE = "/Users/chn/Programmierung/Swift/SiteGenerator/vnzn/xml/content.xml"
    
    private var items: [Item] = []
    private var item = Item()
    private var foundCharacters = ""
    
    func parse() -> [Item] {
        let xmlString = readXmlFile()
        let xmlData = xmlString.data(using: String.Encoding.utf8)!
        let parser = XMLParser(data: xmlData)
        parser.delegate = self;
        parser.parse()
        return items
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "item":
            if let classAttrVal = attributeDict["type"] {
                if classAttrVal == "text" {
                    let textItem = TextPost()
                    if let classAttrVal = attributeDict["format"] {
                        textItem.format = classAttrVal
                    }
                    item = textItem
                }
                else if classAttrVal == "image" {
                    let imageItem = ImagePost()
                    if let classAttrVal = attributeDict["width"] {
                        imageItem.width = Int(classAttrVal)!
                    }
                    if let classAttrVal = attributeDict["height"] {
                        imageItem.height = Int(classAttrVal)!
                    }
                    
                    item = imageItem
                }
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        let trimmedText = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
        switch elementName {
        case "name":
            item.name = trimmedText
        case "title":
            item.title = trimmedText
        case "data":
            item.data = trimmedText
        case "date":
            item.date = parseDate(trimmedText)
        case "t":
            item.tags.insert(trimmedText)
        case "i":
            item.indices.insert(trimmedText)
        case "serial":
            item.serial = trimmedText
        case "item":
            items.append(item)
        default:
            break
        }
        
        foundCharacters = ""
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.foundCharacters += string.replacingOccurrences(of: "\n", with: "", options: NSString.CompareOptions.literal, range:nil)
    }
    
    private func readXmlFile() -> String {
        var xmlString = ""
        
        do {
            xmlString = try String(contentsOf: URL(fileURLWithPath: CONTENT_FILE))
        }
        catch {
            print("Error: \(error)")
        }
        return xmlString
    }
    
    private func parseDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale.init(identifier: "de_DE")
        
        let date = dateFormatter.date(from: dateString)
        return date
    }
}
