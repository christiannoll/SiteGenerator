import Foundation

class ImpressumPage: Page {
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_I = h4([.text("Impressum")])
        mainChildren.append(h_I)
        mainChildren.append(newLine)
        mainChildren.append(createAddress())
        mainChildren.append(newLine)
        mainChildren.append(createEmailAndGithub())
        
        mainChildren.append(newLine)
        
        let h_D = h4([.text("Datenschutzerklärung")])
        mainChildren.append(h_D)
        mainChildren.append(newLine)
        mainChildren.append(createDataProtectionText1())
        mainChildren.append(newLine)
        mainChildren.append(createDataProtectionText2())
        
        mainChildren.append(newLine)
        
        let h_C = h4([.text("© Copyright 2019-2024 – Urheberrechtshinweis")])
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
        pChildren.append(.text("Bautzner Straße 7b"))
        pChildren.append(br())
        pChildren.append(.text("24837 Schleswig"))
        pChildren.append(br())
        
        return p(pChildren)
    }
    
    private func createEmailAndGithub() -> SmlNode {
        let email = "Email: webmaster (at) vnzn (punkt) de"
        var nodes: [SmlNode] = []
        nodes.append(.text(email))
        nodes.append(br())
        nodes.append(contentsOf: createGithubLine())
        nodes.append(br())
        nodes.append(contentsOf: createMastodonLine())
        return p(nodes)
    }
    
    private func createDataProtectionText1() -> SmlNode {
        let s = "Der Webserver schreibt Logdateien mit der IP-Adresse, den verwendeten Browser, Uhrzeit und Datum  und das genutzte System eines Seitenbesuchers. Es werden nur anonymisierte IP-Adressen von Besuchern der Website gespeichert. Auf Webserver-Ebene erfolgt dies dadurch, dass im Logfile standardmäßig statt der tatsächlichen IP-Adresse des Besuchers z.B. 123.123.123.123 eine IP-Adresse 123.123.123.XXX gespeichert wird, wobei XXX ein Zufallswert zwischen 1 und 254 ist. Die Herstellung eines Personenbezuges ist nicht mehr möglich. Es werden keine Benutzerkonten und keine Cookies verwendet, daher betrachte ich diese Logdateien nicht als personenbezogen."
        return p([.text(s)])
    }
    
    private func createDataProtectionText2() -> SmlNode {
        let s = "Abgesehen davon werden keine Daten erhoben, gespeichert oder ausgewertet."
        return p([.text(s)])
    }
    
    private func createCopyrightText() -> SmlNode {
        let s = "Alle Inhalte dieses Internetangebotes, insbesondere Texte, Fotografien, Bilder und Grafiken sind urheberrechtlich geschützt. Das Urheberrecht liegt, soweit nicht ausdrücklich anders gekennzeichnet, bei Christian Noll. Bitte fragen Sie mich, falls Sie die Inhalte dieses Internetangebotes verwenden möchten."
        return p([.text(s)])
    }
}
