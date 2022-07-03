import Foundation

class Page {
    
    public static let baseUrl = "http://localhost:8000/"
    public static let baseRootUrl = "http://localhost:8000/"
    //public static let baseUrl = "https://www.vnzn.de/"
    //public static let baseRootUrl = "https://www.vnzn.de/"
    
    static let homepageTitle = "v.n.z.n"
    static let homepageTagline = "Christian Noll"
    
    private var title = "v.n.z.n"
    
    var tagsTitle: String {
        get { SiteGeneratorEnv.forGerman() ? "Kategorien" : "Tags" }
    }
    
    var indexTitle: String {
        get { "Index" }
    }
    
    var serialsTitle: String {
        get { SiteGeneratorEnv.forGerman() ? "Serien" : "Serials" }
    }
    
    var metaTitle: String {
        get { "Meta" }
    }
    
    var impressumTitle: String {
        get { SiteGeneratorEnv.forGerman() ? "Impressum" : "Contact" }
    }
    
    var statisticsTitle: String {
        get { SiteGeneratorEnv.forGerman() ? "Statistik" : "Statistics" }
    }
    
    var timelineTitle: String {
        get { "Timeline" }
    }
    
    var personsTitle: String {
        get { SiteGeneratorEnv.forGerman() ? "Personen" : "Persons" }
    }
    
    var moviesTitle: String {
        get { SiteGeneratorEnv.forGerman() ? "Filme" : "Movies" }
    }
    
    var booksTitle: String {
        get { SiteGeneratorEnv.forGerman() ? "Bücher" : "Books" }
    }
    
    var photosTitle: String {
        get { SiteGeneratorEnv.forGerman() ? "Fotos" : "Photos" }
    }
    
    var wordCloudTitle: String {
        get { SiteGeneratorEnv.forGerman() ? "Wortwolke" : "Word Cloud" }
    }
    
    var metaDescriptionContent: String {
        get { SiteGeneratorEnv.forGerman() ? "Fragmente aus der Vergangenheit, Gegenwart und Zukunft." : "Fragments from the past, present and future." }
    }
    
    public func render() -> String {
        var htmlChildren: [SmlNode] = []
        htmlChildren.append(newLine)
        
        htmlChildren.append(renderHead())
        htmlChildren.append(newLine)
        
        htmlChildren.append(renderBody())
        htmlChildren.append(newLine)
        
        let root = html(htmlChildren)
        return root.render()
    }
    
    private func renderBody() -> SmlNode {
        var bodyChildren: [SmlNode] = [newLine]
        
        bodyChildren.append(renderBurgerButton())
        bodyChildren.append(newLine)
        
        bodyChildren.append(renderHeader())
        bodyChildren.append(newLine)
        
        bodyChildren.append(renderContent())
        bodyChildren.append(newLine)
        
        bodyChildren.append(renderNav())
        bodyChildren.append(newLine)
        
        bodyChildren.append(renderFooter())
        bodyChildren.append(newLine)
        
        let b = body(bodyChildren)
        return b
    }
    
    private func renderHead() -> SmlNode {
        var headChildren: [SmlNode] = [newLine, tab]
        
        headChildren.append(node("title", [.text(title)]))
        headChildren.append(newLine)
        headChildren.append(tab)
        
        let metaDescription = meta([name => "description", content => metaDescriptionContent])
        headChildren.append(metaDescription)
        headChildren.append(newLine)
        headChildren.append(tab)
        
        let metaViewPort = meta([name => "viewport", content => "width=device-width"])
        headChildren.append(metaViewPort)
        headChildren.append(newLine)
        headChildren.append(tab)
        
        let metaContent = meta([http_equiv => "Content-Type", content => "text/html; charset=utf-8"])
        headChildren.append(metaContent)
        headChildren.append(newLine)
        headChildren.append(tab)
        
        let l = link([rel => "stylesheet", type => "text/css", href => (Page.baseRootUrl + "styles.css")])
        headChildren.append(l)
        headChildren.append(newLine)
        headChildren.append(tab)
        
        let rss = link([rel => "alternate", type => "application/rss+xml", title_attr => "RSS", href => (Page.baseUrl + "xml/rss.xml")])
        headChildren.append(rss)
        headChildren.append(newLine)
        
        let jsInclude = createJavascriptInclude()
        if jsInclude != nil {
            headChildren.append(tab)
            headChildren.append(jsInclude!)
            headChildren.append(newLine)
        }
        
        let h = head(headChildren)
        return h
    }
    
    func setTitle(_ pageTitle: String) {
        title = pageTitle
        title += " | vnzn"
    }
    
    func createJavascriptInclude() -> SmlNode? {
        return nil
    }
    
    func renderContent() -> SmlNode {
        return .text("")
    }
    
    func renderArchiveLink() -> SmlNode {
        let link = a([href => (Page.baseUrl + "archive/")], [SiteGeneratorEnv.forGerman() ? "Archiv": "Archive"])
        let para = p([link])
        return para
    }
    
    func createTwitterLine() -> [SmlNode] {
        var nodes: [SmlNode] = []
        nodes.append(.text("Twitter: "))
        let address = "https://twitter.com/fr0schmidt"
        nodes.append(a([href => (address)], ["@fr0schmidt"]))
        return nodes
    }
    
    func createGithubLine() -> [SmlNode] {
        var nodes: [SmlNode] = []
        nodes.append(.text("GitHub: "))
        let address = "https://github.com/christiannoll"
        nodes.append(a([href => (address)], ["christiannoll"]))
        return nodes
    }
    
    private func renderBurgerButton() -> SmlNode {
        let devMenuLine = div_menuLine([])
        let lineDivs: [SmlNode] = [devMenuLine, devMenuLine, devMenuLine]
        let divNode = div([], lineDivs)
        let link = a([href => "#navLinks"], [divNode])
        return link
    }
    
    private func renderHeader() -> SmlNode {
        var headerChildren: [SmlNode] = [newLine, tab]
        
        let urlTitle: SmlNode = .text(Page.homepageTitle)
        let link = a([href => Page.baseUrl], [urlTitle])
        let spanBigLink = span([id => "biglink"], [link])
        headerChildren.append(spanBigLink)
        headerChildren.append(newLine)
        headerChildren.append(tab)
        
        let title: SmlNode = .text(Page.homepageTagline)
        let spanBigByLine = span([id => "bigbyline"], [title])
        headerChildren.append(spanBigByLine)
        headerChildren.append(newLine)
        
        let h = header(headerChildren)
        return h
    }
    
    private func renderNav() -> SmlNode {
        var navChildren: [SmlNode] = [newLine, tab]
        
        var pChildren: [SmlNode] = []
        let search = a([href => (Page.baseUrl + "search/")], [SiteGeneratorEnv.forGerman() ? "Suche" : "Search"])
        pChildren.append(search)
        pChildren.append(.text(" • "))
        pChildren.append(newLine)
        pChildren.append(tab)
        
        let index = a([href => (Page.baseUrl + "index/")], [.text(indexTitle)])
        pChildren.append(index)
        pChildren.append(.text(" • "))
        pChildren.append(newLine)
        pChildren.append(tab)
        
        let tags = a([href => (Page.baseUrl + "tags/")], [.text(tagsTitle)])
        pChildren.append(tags)
        
        pChildren.append(.text(" • "))
        pChildren.append(newLine)
        pChildren.append(tab)
        
        let serials = a([href => (Page.baseUrl + "serials/")], [.text(serialsTitle)])
        pChildren.append(serials)
        
        pChildren.append(.text(" • "))
        pChildren.append(newLine)
        pChildren.append(tab)
        
        let beta = a([href => (Page.baseUrl + "beta/")], [.text(metaTitle + "*")])
        pChildren.append(beta)
        
        let para = p(pChildren)
        navChildren.append(para)
        navChildren.append(newLine)
        
        var pChildren2: [SmlNode] = []
        let random = a([href => (Page.baseUrl + "random/")], [SiteGeneratorEnv.forGerman() ? "Zufall" : "Random"])
        pChildren2.append(random)

        pChildren2.append(.text(" • "))
        pChildren2.append(newLine)
        pChildren2.append(tab)
        
        let rss = a([href => (Page.baseUrl + "xml/rss.xml")], ["RSS"])
        pChildren2.append(rss)

        pChildren2.append(.text(" • "))
        pChildren2.append(newLine)
        pChildren2.append(tab)
        
        let impressum = a([href => (Page.baseUrl + "impressum/")], [.text(impressumTitle)])
        pChildren2.append(impressum)
        
        let para2 = p(pChildren2)
        navChildren.append(para2)
        navChildren.append(newLine)
        
        var pChildren3: [SmlNode] = []
        let germanLang = a([href => (Page.baseRootUrl)], ["German"])
        let englishLang = a([href => (Page.baseUrl + "en/")], ["English"])
        let lang = SiteGeneratorEnv.forGerman() ? englishLang : germanLang
        pChildren3.append(lang)
        
        let para3 = p(pChildren3)
        navChildren.append(para3)
        navChildren.append(newLine)
        
        let n = nav(navChildren)
        return n
    }
    
    private func renderFooter() -> SmlNode {
        var footerChildren: [SmlNode] = [newLine, tab]
        
        var pChildren: [SmlNode] = []
        pChildren.append(.text("© 2019-2022 "))
        let link = a([href => Page.baseUrl], ["Christian Noll"])
        pChildren.append(link)
        
        let para = p(pChildren)
        footerChildren.append(para)
        footerChildren.append(newLine)
        
        let f = footer(footerChildren)
        return f
    }
    
    private func html(_ children: [SmlNode]) -> SmlNode {
        let language = SiteGeneratorEnv.forGerman() ? "de" : "en"
        return node("html", [lang => language], children)
    }
    
    private func head(_ children: [SmlNode]) -> SmlNode {
        return node("head", children)
    }

    func body(_ children: [SmlNode]) -> SmlNode {
        return node("body", children)
    }
    
    private func nav(_ children: [SmlNode]) -> SmlNode {
        return node("nav", [id => "navLinks"], children)
    }
    
    private func footer(_ children: [SmlNode]) -> SmlNode {
        return node("footer", children)
    }
    
    private func header(_ children: [SmlNode]) -> SmlNode {
        return node("header", children)
    }
    
    func span(_ attribs: [SmlAttribute], _ children: [SmlNode]) -> SmlNode {
        return node("span", attribs, children)
    }
    
    func meta(_ attribs: [SmlAttribute]) -> SmlNode {
        return node("meta", attribs, nil)
    }
    
    func link(_ attribs: [SmlAttribute]) -> SmlNode {
        return node("link", attribs, nil)
    }
    
    func script(_ attribs: [SmlAttribute]) -> SmlNode {
        var dummyChildren: [SmlNode] = []
        dummyChildren.append(.text(""))
        return node("script", attribs, dummyChildren)
    }
    
    func input(_ attribs: [SmlAttribute]) -> SmlNode {
        return node("input", attribs, nil)
    }
    
    let content = SmlAttributeKey<String>("content")
    let name = SmlAttributeKey<String>("name")
    let http_equiv = SmlAttributeKey<String>("http-equiv")
    let rel = SmlAttributeKey<String>("rel")
    let type = SmlAttributeKey<String>("type")
    let src = SmlAttributeKey<String>("src")
    let onLoad = SmlAttributeKey<String>("onLoad")
    let size = SmlAttributeKey<String>("size")
    let onkeyup = SmlAttributeKey<String>("onkeyup")
    let lang = SmlAttributeKey<String>("lang")
}
