import Foundation

class SmlBuilder {
    
    private let baseUrl = "http://localhost:8000/"
    
    public func createArticle(_ item: Item) -> SmlNode {
        let postTitle = createPostTitle(item)
        
        let elements = MarkdownParser.parse(text: item.data)
        let postBody = createPostBody(elements)
        
        let postDateline = createPostDateline(item)
        
        let post = article_post([newLine, tab, postTitle, newLine, tab, postBody, newLine, tab, postDateline, newLine])
        return post
    }
    
    private func createPostBody(_ markdownNodes: [MarkdownNode]) -> SmlNode {
        let p: SmlNode = parse(markdownNodes)
        let postBody = div_postBody([newLine, tab, tab, p, newLine, tab])
        return postBody
    }
    
    private func createPostDateline(_ item: Item) -> SmlNode {
        let urlTitle: SmlNode = .text(createPostDate(item))
        let link = a([href => createPostUrl(item)], [urlTitle])
        let div = div_postDateline([link, newLine, tab])
        return div
    }
    
    private func createPostTitle(_ item: Item) -> SmlNode {
        let urlTitle: SmlNode = .text(item.title)
        let link = a([href => createPostUrl(item)], [urlTitle])
        let h = h3([link])
        return h
    }
    
    private func parse(_ markdownNodes: [MarkdownNode]) -> SmlNode {
        let smlNode: SmlNode = .text(parse(markdownNodes))
        return p([smlNode, newLine, tab, tab])
    }
    
    private func parse(_ markdownNodes: [MarkdownNode]) -> String {
        var s = ""
        for markDownNode: MarkdownNode in markdownNodes {
            switch markDownNode {
            case .text(let text):
                s.append(text)
            case .parenthesis(let nodes):
                s.append("(")
                s.append(parse(nodes))
                s.append(")")
            case .brackets(let nodes):
                s.append("[")
                s.append(parse(nodes))
                s.append("]")
            case .link(let nodes):
                s.append(parseLink(nodes))
            }
        }
        return s
    }
    
    private func parseLink(_ markdownNodes: [MarkdownNode]) -> String {
        var s = ""
        for markDownNode: MarkdownNode in markdownNodes {
            switch markDownNode {
            case .text(let text):
                s.append(text)
            case .parenthesis(let nodes):
                s.append("<a href=\"")
                s.append(parse(nodes))
                s.append("\">")
            case .brackets(let nodes):
                s.append(parse(nodes))
                s.append("</a>")
            default:
                break
            }
        }
        return s
    }
    
    private func createPostUrl(_ item: Item) -> String {
        var url = baseUrl
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "/yyyy/MM/dd/"
        url.append(dateFormatter.string(from: item.date!))
        url.append(item.name)
        
        return url
    }
    
    private func createPostDate(_ item: Item) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: item.date!)
    }
}
