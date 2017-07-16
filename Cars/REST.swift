import Foundation

class REST {
    // static let basePath = "https://fiapcars.herokuapp.com/cars"
    static let basePath = "https://api.punkapi.com/v2/beers"
    
    static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        config.timeoutIntervalForRequest = 45.0
        config.httpMaximumConnectionsPerHost = 5
        
        return config
    }()
    
    static let session = URLSession(configuration: configuration)
    
    static func loadItems(onComplete: @escaping ([Beer]?) -> Void) {
        guard let url = URL(string: basePath) else {
            onComplete(nil)
            return
        }
        
        session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                onComplete(nil)
            } else {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else {
                        onComplete(nil)
                        return
                    }
                    
                    let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
                    
                    var items: [Beer] = []
                    for item in json {
                        
                        let name = item["name"] as! String
                        let description = item["description"] as! String
                        let firstBrewed = item["first_brewed"] as! String
                        
                        let id = item["id"] as! Int
                        let item = Beer(name: name, description: description, firstBrewed: firstBrewed)
                        item.id = id
                        items.append(item)
                    }
                    
                    onComplete(items)
                } else {
                    onComplete(nil)
                }
            }
        }.resume()
    }
}
