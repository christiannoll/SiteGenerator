import Foundation

class RegisterItem : PostListItem {
    
    private let _content: String
 
    init(_ content: String) {
        self._content = content
    }
    
    var content: String {
        get { return _content }
    }
    
    func renderRegisterCloudItem() -> SmlNode {
        let link = a([href => createLinkUrl(), style => getStyleAttributeText()], [createRegisterCloudLinkTitle()])
        return link
    }
    
    private func createLinkUrl() -> String {
        return Page.baseUrl + "persons/#" + _content.convertToUrlPath()
    }
    
    private func createRegisterCloudLinkTitle() -> SmlNode {
        return .text(_content)
    }
    
    private func getStyleAttributeText() -> String {
        let fontSizeText = numberOfPosts < 10 ? "font-size:1.\(numberOfPosts)em;" : "font-size:\(Double(numberOfPosts + 10) / 10.0)em;"
        
        let color = FormatBuilder.randomColors[Int.random(in: 0 ..< FormatBuilder.randomColors.count)]
        let colorText = " color:\(color);"
        
        return fontSizeText + colorText
    }
}
