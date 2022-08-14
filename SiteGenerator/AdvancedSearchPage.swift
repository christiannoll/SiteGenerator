import Foundation

class AdvancedSearchPage: SearchPage {
    
    override var searchCallString: String {
        get { "advancedSearch(this.value)"  }
    }
    
    override var searchTip: String {
        get { SiteGeneratorEnv.forGerman() ? "Suche mit Komma ..." : "Search with comma ..." }
    }
}
