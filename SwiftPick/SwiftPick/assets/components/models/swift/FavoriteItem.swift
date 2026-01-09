import Foundation
import SwiftData

@Model
public class FavoriteItem {
    public var productId: Int
    public var productName: String
    public var productImage: String
    public var productRating: Int
    public var productPrice: Double
    
    public init(
        productId: Int,
        productName: String,
        productImage: String,
        productRating: Int,
        productPrice: Double
    ) {
        self.productId = productId
        self.productName = productName
        self.productImage = productImage
        self.productRating = productRating
        self.productPrice = productPrice
    }//init
}//FavoriteItem
