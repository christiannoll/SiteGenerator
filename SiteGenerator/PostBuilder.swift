import Foundation

class PostBuilder {
    
    public static func createDatePath(_ item: Item) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "yyyy/MM/dd/"
        return dateFormatter.string(from: item.date!)
    }
    
    public func createTextArticle(_ item: TextPost) -> SmlNode {
        let postTitle = createPostTitle(item)
        
        let postBody = createTextPostBody(item)
        
        let postDateline = createTextPostDateline(item)
        
        let post = article_post([newLine, tab, postTitle, newLine, tab, postBody, newLine, tab, postDateline, newLine])
        return post
    }
    
    public func createImageArticle(_ item: ImagePost) -> SmlNode {
        let postBody = createImagePostBody(item)
        let postDateline = createImagePostDateline(item)
        
        let post = article_post([newLine, tab, postBody, newLine, tab, postDateline, newLine])
        return post
    }
    
    public func createPostLink(_ post: Item) -> SmlNode {
        let urlTitle: SmlNode = .text(post.title)
        let link = a([href => createPostUrl(post)], [urlTitle])
        return link
    }

    private func createImagePostBody(_ item: ImagePost) -> SmlNode {
        let imgNode: SmlNode = img([css_class => "centeredImage",
                                    src => createImageUrl(item),
                                    height => String(item.height),
                                    width => String(item.width),
                                    alt => String(item.title)])
        let para = p([imgNode, newLine, tab, tab])
        let postBody = div_postBody([newLine, tab, tab, para, newLine, tab])
        return postBody
    }
    
    private func createTextPostParagraph(_ markdownNodes: [MarkdownNode]) -> SmlNode {
        return parse(markdownNodes)
    }
    
    private func createTextPostBody(_ item: TextPost) -> SmlNode {
        var children = [newLine, tab, tab]
        
        let paragraphs = item.data.components(separatedBy: "\t")
        for paragraph: String in paragraphs {
            let p = createTextPostParagraph(MarkdownParser.parse(text: paragraph))
            children.append(p)
        }
        
        children.append(newLine)
        children.append(tab)
        let postBody = div_postBody(children)
        return postBody
    }
    
    private func createTextPostDateline(_ item: Item) -> SmlNode {
        let urlTitle: SmlNode = .text(createPostDate(item))
        let link = a([href => createPostUrl(item)], [urlTitle])
        let div = div_postDateline([link, newLine, tab])
        return div
    }
    
    private func createImagePostDateline(_ item: Item) -> SmlNode {
        let urlTitle: SmlNode = .text(createPostDate(item))
        let link = a([href => createPostUrl(item)], [urlTitle])
        let div = div_postStyledDateline([link, newLine, tab])
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
        var url = Page.baseUrl
        
        url.append(PostBuilder.createDatePath(item))
        url.append(item.name)
        
        return url
    }
    
    private func createImageUrl(_ item: Item) -> String {
        var url = Page.baseUrl
        url.append("images/")
        url.append(item.data)
        return url
    }
    
    private func createPostDate(_ item: Item) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: item.date!)
    }
}
