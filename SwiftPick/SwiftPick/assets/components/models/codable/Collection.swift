import Foundation

public class Collection: Identifiable, Codable {
    public let collectionId: Int
    public let categoryId: Int
    public let collectionName: String
    
    public var id: UUID {
        return UUID()
    }//id
}//Collection

public class Collections: Codable {
    public var data: [Collection]
}//Collections
