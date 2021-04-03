import Foundation

class FormatBuilder {
    
    // https://www.w3schools.com/cssref/css_colors.asp
    private let colors = ["CornflowerBlue", "DarkOrange", "DeepPink", "FireBrick", "ForestGreen", "DarkGrey", "DarkGoldenRod", "Blue", "DarkViolet", "Gold", "SeaGreen"]
    
    func parse(_ markdownNodes: [MarkdownNode], _ textPost: TextPost) -> [MarkdownNode] {
        if textPost.format == "randomWordColor" {
            return parseText(elements: markdownNodes)
        }
        else if textPost.format == "randomLinkColor" {
            return parseLinks(elements: markdownNodes)
        }
        return markdownNodes
    }
    
    private func parseText(elements: [MarkdownNode]) -> [MarkdownNode] {
        var nodes: [MarkdownNode] = []
        
        for element in elements {
            switch element {
            case .text(let s):
                nodes.append(contentsOf: buildColorNodes(text: s))
            case .olistelement(let mdNodes):
                fallthrough
            case .ulistelement(let mdNodes):
                nodes.append(contentsOf: parseText(elements:mdNodes))
            case .bold(let mdNodes):
                nodes.append(contentsOf: parseText(elements:mdNodes))
            case .italic(let mdNodes):
                nodes.append(contentsOf: parseText(elements:mdNodes))
            case .code(let mdNodes):
                nodes.append(contentsOf: parseText(elements:mdNodes))
            case .ulist(let mdNodes):
                nodes.append(contentsOf: parseText(elements:mdNodes))
            case .olist(let mdNodes):
                nodes.append(contentsOf: parseText(elements:mdNodes))
            default:
                nodes.append(element)
            }
        }
        
        return nodes
    }
    
    private func buildColorNodes(text: String) -> [MarkdownNode] {
        var colorNodes: [MarkdownNode] = []
        
        let words = text.components(separatedBy: CharacterSet.whitespaces)
        for word in words {
            if word.count > 1 {
                colorNodes.append(.color(colors[Int.random(in: 0 ..< colors.count)], [.text(word)]))
            }
            else {
                colorNodes.append(.text(word))
            }
            
            colorNodes.append(.text(" "))
        }
        colorNodes.removeLast()
        
        return colorNodes
    }
    
    private func parseLinks(elements: [MarkdownNode]) -> [MarkdownNode] {
        var nodes: [MarkdownNode] = []
        
        for element in elements {
            switch element {
            case .link(let mdNodes):
                nodes.append(.link(parseLink(mdNodes)))
            case .ulist(let mdNodes):
                nodes.append(.ulist(parseLinks(elements:mdNodes)))
            case .olist(let mdNodes):
                nodes.append(.olist(parseLinks(elements:mdNodes)))
            case .olistelement(let mdNodes):
                nodes.append(.olistelement(parseLinks(elements:mdNodes)))
            case .ulistelement(let mdNodes):
                nodes.append(.ulistelement(parseLinks(elements:mdNodes)))
            default:
                nodes.append(element)
            }
        }
        return nodes
    }
    
    private func parseLink(_ markdownNodes: [MarkdownNode]) -> [MarkdownNode] {
        var nodes: [MarkdownNode] = []
        
        for markDownNode in markdownNodes {
            switch markDownNode {
            case .brackets(let mdNodes):
                nodes.append(.brackets(parseText(elements: mdNodes)))
                break
            default:
                nodes.append(markDownNode)
            }
        }
        return nodes
    }
    
}
