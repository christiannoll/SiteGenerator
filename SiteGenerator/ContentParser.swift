import Foundation

class ContentParser : NSObject, XMLParserDelegate {
    
    private let CONTENT_FILE =  SiteGeneratorEnv.baseDir + "xml/content.xml"
    
    private var items: [Item] = []
    private var item = Item(-1)
    private var foundCharacters = ""
    private var indexIsPerson = false
    
    func parse() -> [Item] {
        return parse(CONTENT_FILE)
    }
    
    func parse(_ filePath: String) -> [Item] {
        let xmlString = readXmlFile(filePath)
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
                    let textItem = TextPost(items.count + 1)
                    if let classAttrVal = attributeDict["format"] {
                        textItem.format = classAttrVal
                    }
                    item = textItem
                }
                else if classAttrVal == "image" {
                    let imageItem = ImagePost(items.count + 1)
                    if let classAttrVal = attributeDict["width"] {
                        imageItem.width = Int(classAttrVal)!
                    }
                    if let classAttrVal = attributeDict["height"] {
                        imageItem.height = Int(classAttrVal)!
                    }
                    
                    item = imageItem
                }
            }
        case "i":
            if let classAttrVal = attributeDict["type"] {
                indexIsPerson = isIndexPerson(classAttrVal)
            }
            else {
                indexIsPerson = false
            }
            break
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
            if indexIsPerson {
                item.persons.insert(trimmedText)
            }
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
    
    private func readXmlFile(_ filePath: String) -> String {
        var xmlString = ""
        
        do {
            xmlString = try String(contentsOf: URL(fileURLWithPath: filePath))
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
    
    private func isIndexPerson(_ typeString: String) -> Bool {
        let validStrings = ["Person", "Musiker", "Physiker", "Philosoph", "Komponist"]
        return validStrings.contains(typeString)
    }
}
