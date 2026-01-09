import Foundation

public class Category: Identifiable, Codable {
    public let categoryId: Int
    public let categoryName: String
    
    public var id: UUID {
        return UUID()
    }//id
}//Category

public class Categories: Codable {
    public var data: [Category]
}//Categories
