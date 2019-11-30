import Foundation

class Page {
    
    public func render() -> String {
        var s = renderHeader()
        s.append(renderContent())
        s.append(renderFooter())
        return s
    }
    
    private func renderHeader() -> String {
        return ""
    }
    
    func renderContent() -> String {
        return ""
    }
    
    private func renderFooter() -> String {
        return ""
    }
}
