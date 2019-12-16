import Foundation

class PageLoader {
    
    func loadPage(from urlString: String, completionHandler: @escaping (_ URLResponse: URLResponse?) ->()) {
        let session = URLSession.shared
        let url = URL(string: urlString)
        
        let sema = DispatchSemaphore(value: 0)
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            completionHandler(response)
            
            sema.signal()
        }
        
        task.resume()
        sema.wait()
    }
}
