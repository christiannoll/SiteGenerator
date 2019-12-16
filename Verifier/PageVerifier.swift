import Foundation

class PageVerifier {
    
    func verify() {
        //let contentParser = ContentParser()
        // posts = contentParser.parse()
        
        let pageLoader = PageLoader()
        pageLoader.loadPage(from: Page.baseUrl + "/index.html") { (response) in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            print("ok")
        }
    }
}
