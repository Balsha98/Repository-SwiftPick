import Foundation
import Firebase
import FirebaseAuth

@Observable
public class CartHandler {
    public var cartItems: [CartItem] = []
    
    private let database: Firestore = Firestore.firestore()
    
    private let user: User = Auth.auth().currentUser!
    
    public func fetchCartItems() {
        self.cartItems.removeAll()
        
        let collection = self.database.collection("carts")
        
        collection.getDocuments { snapshot, error in
            if let error = error {
                print("Error Caught - Error while fetching cart items.")
                print("Error Details - \(error.localizedDescription)")
                
                return
            }//if
            
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    for document in snapshot.documents {
                        if document.documentID.contains("|") {
                            let documentUserId = document.documentID.components(separatedBy: "|")[0]
                            
                            if documentUserId == self.user.uid {
                                let data = document.data()
                                
                                let productId = data["productId"] as? Int ?? 0
                                let productName = data["productName"] as? String ?? ""
                                let productImage = data["productImage"] as? String ?? ""
                                let productSize = data["productSize"] as? String ?? ""
                                let productColor = data["productColor"] as? String ?? ""
                                let productRewardPoints = data["productRewardPoints"] as? Int ?? 0
                                let productRating = data["productRating"] as? Int ?? 0
                                let productQuantity = data["productQuantity"] as? Int ?? 0
                                let productPrice = data["productPrice"] as? Double ?? 0
                                
                                let cartItem = CartItem(
                                    productId: productId,
                                    productName: productName,
                                    productImage: productImage,
                                    productSize: productSize,
                                    productColor: productColor,
                                    productRewardPoints: productRewardPoints,
                                    productRating: productRating,
                                    productQuantity: productQuantity,
                                    productPrice: productPrice
                                )//cartItem
                                
                                self.cartItems.append(cartItem)
                            }//if
                        }//if
                    }//for
                }//async
            }//if
        }//getDocuments
    }//fetchCartItems
    
    public func addCartItem(_ cartItem: CartItem) {
        let collection = self.database.collection("carts")
        
        let document = collection.document("\(self.user.uid)|\(cartItem.productId)")
        
        document.setData([
            "productId": cartItem.productId,
            "productName": cartItem.productName,
            "productImage": cartItem.productImage,
            "productSize": cartItem.productSize,
            "productColor": cartItem.productColor,
            "productRewardPoints": cartItem.productRewardPoints,
            "productRating": cartItem.productRating,
            "productQuantity": cartItem.productQuantity,
            "productPrice": cartItem.productPrice
        ]) { error in
            if let error = error {
                print("Error Caught - Error while adding a cart item.")
                print("Error Details - \(error.localizedDescription)")
                
                return
            }//if
        }//setData
    }//addCartItem
    
    public func deleteCartItem(_ productId: Int) {
        let collection = self.database.collection("carts")
        
        let document = collection.document("\(self.user.uid)|\(productId)")
        
        document.delete { error in
            if let error = error {
                print("Error Caught - Error while deleting a cart item.")
                print("Error Details - \(error.localizedDescription)")
                
                return
            }//if
        }//delete
    }//deleteCartItem
}//CartHandler
