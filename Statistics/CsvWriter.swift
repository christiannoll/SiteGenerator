import Foundation

class CsvWriter {
    
    func writeCsvFile() {
        do {
            let csvContent = "data"
            let fileName = "site_statistics.csv"
            let relPath = "csv/"
            let path = PageWriter.baseDir + relPath
            if relPath.count > 0 {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            try csvContent.write(to: URL(fileURLWithPath: path + fileName), atomically: false, encoding: .utf8)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
}
