import Foundation

class Beer {
    var name: String
    var description: String
    var firstBrewed: String
    var id: Int?
    
    init (name: String, description: String, firstBrewed: String) {
        self.name = name;
        self.description = description;
        self.firstBrewed = firstBrewed;
    }
}
