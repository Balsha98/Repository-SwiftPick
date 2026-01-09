import Foundation

public class ReviewItem: Identifiable {
    public let productId: Int
    public let fullName: String
    public let rating: Int
    public let review: String
    
    public var id: UUID {
        return UUID()
    }//id
    
    public init(
        productId: Int,
        fullName: String,
        rating: Int,
        review: String
    ) {
        self.productId = productId
        self.fullName = fullName
        self.rating = rating
        self.review = review
    }//init
}//ReviewItem
