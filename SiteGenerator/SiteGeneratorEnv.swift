import Foundation

struct SiteGeneratorEnv {
    
    //static let baseDir = "/Users/chn/Programmierung/Swift/SiteGenerator/vnzn/en/"
    static let baseDir = "/Users/chn/Programmierung/Swift/SiteGenerator/vnzn/"
    
    static func forGerman() -> Bool {
        let lang = UserDefaults.standard.string(forKey: "AppleLanguage")
        return lang == "de"
    }
}
