import Foundation

public class CartItem: Identifiable, Codable {
    public var productId: Int
    public var productName: String
    public var productImage: String
    public var productSize: String
    public var productColor: String
    public var productRewardPoints: Int
    public var productRating: Int
    public var productQuantity: Int
    public var productPrice: Double
    
    public var id: UUID {
        return UUID()
    }//id
    
    public init(
        productId: Int,
        productName: String,
        productImage: String,
        productSize: String,
        productColor: String,
        productRewardPoints: Int,
        productRating: Int,
        productQuantity: Int,
        productPrice: Double
    ) {
        self.productId = productId
        self.productName = productName
        self.productImage = productImage
        self.productSize = productSize
        self.productColor = productColor
        self.productRewardPoints = productRewardPoints
        self.productRating = productRating
        self.productQuantity = productQuantity
        self.productPrice = productPrice
    }//init
}//CartItem
