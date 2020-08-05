import Foundation

class ContactPage: Page {
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_I = h4([.text("Contact")])
        mainChildren.append(h_I)
        mainChildren.append(newLine)
        mainChildren.append(createAddress())
        mainChildren.append(newLine)
        
        let h_C = h4([.text("© Copyright 2019-2020 – Copyright notice")])
        mainChildren.append(h_C)
        mainChildren.append(newLine)
        mainChildren.append(createCopyrightText())
        
        mainChildren.append(newLine)
        
        return main(mainChildren)
    }
    
    private func createAddress() -> SmlNode {
        var pChildren: [SmlNode] = []
        pChildren.append(.text("v.n.z.n (Christian Noll)"))
        pChildren.append(br())
        pChildren.append(.text("Email: webmaster (at) vnzn (punkt) de"))
        return p(pChildren)
    }
    
    private func createCopyrightText() -> SmlNode {
        let s = "All contents of this website, in particular texts, photographs and graphics, are protected by copyright. The copyright is, unless otherwise expressly indicated, with Christian Noll. Please ask me if you would like to use the contents of this website."
        return p([.text(s)])
    }
}
