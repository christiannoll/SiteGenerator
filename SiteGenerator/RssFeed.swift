import Foundation

class RssFeed {
    
    private var posts: [Item]
    
    init(_ posts: [Item]) {
        self.posts = posts
    }
    
    func render() -> String {
        return renderContent().render()
    }
    
    private func renderContent() -> SmlNode {
        var channelChildren: [SmlNode] = [newLine]
        
        channelChildren.append(title_node(Page.homepageTitle))
        channelChildren.append(newLine)
        
        channelChildren.append(link_node(Page.baseUrl))
        channelChildren.append(newLine)
        
        channelChildren.append(description_node(Page.homepageTagline))
        channelChildren.append(newLine)
        
        channelChildren.append(language_node(SiteGeneratorEnv.forGerman() ? "de" : "en"))
        channelChildren.append(newLine)
        
        var index = 1
        for post in posts {
            channelChildren.append(post.renderRss())
            channelChildren.append(newLine)
            if index >= HomePage.max_number_of_posts {
                break
            }
            index += 1
        }
        
        let channel = channel_node(channelChildren)
        let rss = rss_node([newLine, channel, newLine])
        return rss
    }
    
}
