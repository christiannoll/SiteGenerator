import Foundation

class ContactPage: Page {
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_I = h4([.text("Contact")])
        mainChildren.append(h_I)
        mainChildren.append(newLine)
        mainChildren.append(createAddress())
        mainChildren.append(newLine)
        
        let h_C = h4([.text("© Copyright 2019-2023 – Copyright notice")])
        mainChildren.append(h_C)
        mainChildren.append(newLine)
        mainChildren.append(createCopyrightText())
        
        mainChildren.append(newLine)
        
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(impressumTitle)
    }
    
    private func createAddress() -> SmlNode {
        var pChildren: [SmlNode] = []
        pChildren.append(.text("v.n.z.n (Christian Noll)"))
        pChildren.append(br())
        pChildren.append(.text("Email: webmaster (at) vnzn (punkt) de"))
        pChildren.append(br())
        pChildren.append(contentsOf: createGithubLine())
        pChildren.append(br())
        pChildren.append(contentsOf: createMastodonLine())
        return p(pChildren)
    }
    
    private func createCopyrightText() -> SmlNode {
        let s = "All contents of this website, in particular texts, photographs, images and graphics, are protected by copyright. The copyright is, unless otherwise expressly indicated, with Christian Noll. Please ask me if you would like to use the contents of this website."
        return p([.text(s)])
    }
}
