import Foundation

class FormatBuilder {
    
    // https://www.w3schools.com/cssref/css_colors.asp
    private var colors: [String] = []
    private let randomColors = ["CornflowerBlue", "DarkOrange", "DeepPink", "FireBrick", "ForestGreen", "DarkGrey", "DarkGoldenRod", "Blue", "DarkViolet", "Gold", "SeaGreen"]
    private let blueColors = ["Blue", "CornflowerBlue", "DarkBlue", "DarkSlateBlue", "DodgerBlue", "DeepSkyBlue", "LightSkyBlue", "MediumBlue", "MidNightBlue", "Navy", "RoyalBlue", "SteelBlue"]
    private var separateWords = true
    
    func parse(_ markdownNodes: [MarkdownNode], _ textPost: TextPost) -> [MarkdownNode] {
        separateWords = true
        
        if textPost.format == "randomWordColor" {
            colors = randomColors
            return parseText(elements: markdownNodes)
        }
        else if textPost.format == "randomLinkColor" {
            colors = randomColors
            return parseLinks(elements: markdownNodes)
        }
        else if textPost.format == "blueLinkColor" {
            colors = blueColors
            return parseLinks(elements: markdownNodes)
        }
        else if textPost.format == "randomLinksColor" {
            separateWords = false
            colors = randomColors
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
        
        let words = separateWords ? text.components(separatedBy: CharacterSet.whitespaces) : [text]
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
            case .parenthesis(let mdNodes):
                nodes.append(.parenthesis(parseLinks(elements:mdNodes)))
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
                nodes.append(.brackets(parseText(elements: combineTextNodes(mdNodes))))
                break
            default:
                nodes.append(markDownNode)
            }
        }
        return nodes
    }
    
    private func combineTextNodes(_ textNodes: [MarkdownNode]) -> [MarkdownNode] {
        let combinedText = combineText(textNodes)
        return [.text(combinedText)]
    }
 
    private func combineText(_ textNodes: [MarkdownNode]) -> String {
        var combinedText = ""
        for textNode in textNodes {
            switch textNode {
            case .text(let text):
                combinedText += text
                break
            case .parenthesis(let mdNodes):
                combinedText += combineText(mdNodes)
                break
            default:
                fatalError()
            }
        }
        return combinedText
    }
}
