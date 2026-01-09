import Foundation

public class Product: Identifiable, Codable {
    public let productId: Int
    public let productName: String
    public let categoryId: Int
    public let collectionId: Int
    public let productSizes: [String]
    public let productColors: [String]
    public let productRewardPoints: Int
    public let productRating: Int
    public let productImages: [String]
    public let productPrice: Double
    
    public var id: UUID {
        return UUID()
    }//id
}//Product

public class Products: Codable {
    public var data: [Product]
}//Products
