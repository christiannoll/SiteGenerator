import Foundation

class PostBuilder {
    
    private let smlBuilder = SmlBuilder()
    private let formatBuilder = FormatBuilder()
    
    public static func createDatePath(_ item: Item) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "yyyy/MM/dd/"
        return dateFormatter.string(from: item.date!)
    }
    
    static func createPostUrl(_ item: Item) -> String {
        var url = Page.baseUrl
        
        url.append(PostBuilder.createDatePath(item))
        url.append(item.name)
        
        return url
    }
    
    public func createTextArticle(_ item: TextPost) -> SmlNode {
        let postTitle = createPostTitle(item)
        
        let nodes = MarkdownParser.parse(text: item.data)
        parseLinks(item, nodes)
        parseYears(item, nodes)
        
        let elements = formatBuilder.parse(nodes, item)
        
        let postBody = createTextPostBody(elements)
        
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
    
    func createRssTextArticle(_ item: TextPost) -> SmlNode {
        return createRssArticle(item, createRssTextPostDescription)
    }
    
    func createRssImageArticle(_ item: ImagePost) -> SmlNode {
        return createRssArticle(item, createRssImagePostDescription)
    }
    
    private func createRssArticle(_ item: Item, _ createDescription:(Item) -> String) -> SmlNode {
        let postTitle = title_node(item.title.htmlEncodedString())
        let postLink = link_node(PostBuilder.createPostUrl(item))
        let postGuid = guid_node(PostBuilder.createPostUrl(item))
        let postPubDate = pubDate_node(createPubDate(item))
        let postDescription = description_node(createDescription(item))
        let post = item_node([newLine, tab, postTitle, newLine, tab, postLink, newLine, tab, postGuid, newLine, tab, postPubDate, newLine, tab, postDescription, newLine])
        return post
    }
    
    public func createPostLink(_ post: Item) -> SmlNode {
        let urlTitle = post.renderUrlTitle()
        let link = a([href => PostBuilder.createPostUrl(post)], [urlTitle])
        return link
    }

    private func createImagePostBody(_ item: ImagePost) -> SmlNode {
        let imgNode: SmlNode = img([css_class => "centeredImage",
                                    src => createImageUrl(item),
                                    height => String(item.height),
                                    width => String(item.width),
                                    alt => String(item.title)])
        let link = a([href => PostBuilder.createPostUrl(item)], [imgNode])
        let para = p([link, newLine, tab, tab])
        let postBody = div_postBody([newLine, tab, tab, para, newLine, tab])
        return postBody
    }
    
    private func createTextPostBody(_ markdownNodes: [MarkdownNode]) -> SmlNode {
        let para = p([smlBuilder.parse(markdownNodes)])
        let postBody = div_postBody([newLine, tab, tab, para, newLine, tab])
        return postBody
    }
    
    private func createTextPostDateline(_ item: Item) -> SmlNode {
        let urlTitle: SmlNode = .text(createPostDate(item))
        let link = a([href => PostBuilder.createPostUrl(item)], [urlTitle])
        let div = div_postDateline([link, newLine, tab])
        return div
    }
    
    private func createImagePostDateline(_ item: Item) -> SmlNode {
        let urlTitle: SmlNode = .text(createPostDate(item))
        let link = a([href => PostBuilder.createPostUrl(item)], [urlTitle])
        let div = div_postStyledDateline([link, newLine, tab])
        return div
    }
    
    private func createPostTitle(_ item: Item) -> SmlNode {
        let urlTitle: SmlNode = .text(item.title)
        let link = a([href => PostBuilder.createPostUrl(item)], [urlTitle])
        let h = h3([link])
        return h
    }
    
    private func createImageUrl(_ item: Item) -> String {
        var url = Page.baseRootUrl
        url.append("images/")
        url.append(item.data)
        return url
    }
    
    private func createPostDate(_ item: Item) -> String {
        let dateFormatter = DateFormatter()
        if (SiteGeneratorEnv.forGerman()) {
            dateFormatter.locale = Locale(identifier: "de_DE")
        }
        else {
            dateFormatter.locale = Locale(identifier: "en_US")
        }
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: item.date!)
    }
    
    private func createPubDate(_ item: Item) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        return dateFormatter.string(from: item.date!)
    }
    
    private func createRssTextPostDescription(_ item: Item) -> String {
        let markdownNodes = formatBuilder.parse(MarkdownParser.parse(text: item.data), item as! TextPost)
        let html = smlBuilder.parse(markdownNodes).render()
        return html.htmlEncodedString()
    }
    
    private func createRssImagePostDescription(_ item: Item) -> String {
        let imgItem = item as! ImagePost
        var content = "<![CDATA["
        
        let imgNode: SmlNode = img([css_class => "centeredImage",
                                    src => createImageUrl(imgItem),
                                    height => String(imgItem.height),
                                    width => String(imgItem.width),
                                    alt => String(imgItem.title)])
        content += imgNode.render()
        content += "]]>"
        return content
    }
    
    private func parseLinks(_ item: Item, _ markdownNodes: [MarkdownNode]) {
        let linkParser = LinkParser()
        var links: [String: String] = [:]
        linkParser.parse(markdownNodes, &links)
        item.links = links
    }
    
    private func parseYears(_ item: Item, _ markdownNodes: [MarkdownNode]) {
        let yearParser = YearParser()
        var years: [Int] = []
        yearParser.parse(markdownNodes, &years)
        item.years = years
    }
}
