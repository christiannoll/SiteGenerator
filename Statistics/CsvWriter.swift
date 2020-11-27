import Foundation

class CsvWriter {
    
    func writeData(_ data: StatisticData) {
        var s = "Date,Words,Links,Image, Serial\n"
        for postData in data.postsData {
            s.append(postData.publishDate)
            s.append(",")
            s.append(String(postData.wordCount))
            s.append(",")
            s.append(String(postData.linkCount))
            s.append(",")
            s.append(postData.imagePost ? "true" : "false")
            s.append(",")
            s.append(postData.serialPost ? "true" : "false")
            s.append("\n")
        }
        
        writeCsvFile(s)
    }
    
    private func writeCsvFile(_ content: String) {
        do {
            let fileName = "site_statistics.csv"
            let relPath = "csv/"
            let path = SiteGeneratorEnv.baseDir + relPath
            if relPath.count > 0 {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            try content.write(to: URL(fileURLWithPath: path + fileName), atomically: false, encoding: .utf8)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
}
