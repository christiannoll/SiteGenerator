import Foundation

class ContentParser : NSObject, XMLParserDelegate {
    
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
                    item = TextPost()
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
                //items.append(item)
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
            let path = "/Users/chn/Programmierung/Swift/SiteGenerator/SiteGenerator/content.xml"
            xmlString = try String(contentsOf: URL(fileURLWithPath: path))
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
