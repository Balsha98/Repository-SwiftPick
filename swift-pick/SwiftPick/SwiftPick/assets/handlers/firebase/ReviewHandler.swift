import Foundation
import Firebase
import FirebaseAuth

@Observable
public class ReviewHandler {
    public var reviewItems: [ReviewItem] = []
    
    private let database: Firestore = Firestore.firestore()
    
    private let user: User = Auth.auth().currentUser!
    
    public func fetchProductReviews(_ productId: Int) {
        self.reviewItems.removeAll()
        
        let collection = self.database.collection("reviews")
        
        collection.getDocuments { snapshot, error in
            if let error = error {
                print("Error Caught - Error while fetching the user profile.")
                print("Error Details - \(error.localizedDescription)")
                
                return
            }//if
            
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    for document in snapshot.documents {
                        if document.documentID.contains("|") {
                            let documentProductId = Int(document.documentID.components(separatedBy: "|")[1])
                            
                            if documentProductId == productId {
                                let data = document.data()
                                
                                let productId = data["productId"] as? Int ?? 0
                                let fullName = data["fullName"] as? String ?? ""
                                let rating = data["rating"] as? Int ?? 0
                                let review = data["review"] as? String ?? ""
                                
                                let reviewItem = ReviewItem(
                                    productId: productId,
                                    fullName: fullName,
                                    rating: rating,
                                    review: review
                                )//reviewItem
                                
                                self.reviewItems.append(reviewItem)
                            }//if
                        }//if
                    }//for
                }//async
            }//if
        }//getDocument
    }//fetchProductReviews
    
    public func addNewReviewItem(_ reviewItem: ReviewItem) {
        let documentId = "\(self.user.uid)|\(reviewItem.productId)|\(Date().timeIntervalSince1970)"
        
        self.database.collection("reviews").document(documentId).setData([
            "productId": reviewItem.productId,
            "fullName": reviewItem.fullName,
            "rating": reviewItem.rating,
            "review": reviewItem.review,
        ]) { error in
            if let error = error {
                print("Error Caught - Error while updating a user profile field.")
                print("Error Details - \(error.localizedDescription)")
                
                return
            }//if
        }//setData
    }//addNewReviewItem
}//ReviewHandler
