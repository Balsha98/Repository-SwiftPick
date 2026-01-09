import Foundation
import Firebase
import FirebaseAuth

@Observable
public class OrderHandler {
    public var orderItems: [OrderItem] = []
    
    private let database: Firestore = Firestore.firestore()
    
    private let user: User = Auth.auth().currentUser!
    
    public func fetchUserOrders() {
        self.orderItems.removeAll()
        
        let collection = self.database.collection("orders")
        
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
                            let documentUserId = document.documentID.components(separatedBy: "|")[0]
                            
                            if documentUserId == self.user.uid {
                                let data = document.data()
                                
                                let email = data["email"] as? String ?? ""
                                let receiveEmailUpdates = data["receiveEmailUpdates"] as? Bool ?? false
                                let countryOrRegion = data["countryOrRegion"] as? String ?? ""
                                let firstName = data["firstName"] as? String ?? ""
                                let lastName = data["lastName"] as? String ?? ""
                                let company = data["company"] as? String ?? ""
                                let address = data["address"] as? String ?? ""
                                let apartmentOrSuite = data["apartmentOrSuite"] as? String ?? ""
                                let city = data["city"] as? String ?? ""
                                let zipCode = data["zipCode"] as? String ?? ""
                                let state = data["state"] as? String ?? ""
                                let phoneNumber = data["phoneNumber"] as? String ?? ""
                                let receiveTextUpdates = data["receiveTextUpdates"] as? Bool ?? false
                                let shippingMethod = data["shippingMethod"] as? String ?? ""
                                let agreeToTerms = data["agreeToTerms"] as? Bool ?? false
                                let productIDs = data["productIDs"] as? [Int] ?? []
                                let rewardsPoints = data["rewardsPoints"] as? Int ?? 0
                                let totalPrice = data["totalPrice"] as? Double ?? 0
                                
                                let orderItem = OrderItem(
                                    userId: self.user.uid,
                                    email: email,
                                    receiveEmailUpdates: receiveEmailUpdates,
                                    countryOrRegion: countryOrRegion,
                                    firstName: firstName,
                                    lastName: lastName,
                                    company: company,
                                    address: address,
                                    apartmentOrSuite: apartmentOrSuite,
                                    city: city,
                                    zipCode: zipCode,
                                    state: state,
                                    phoneNumber: phoneNumber,
                                    receiveTextUpdates: receiveTextUpdates,
                                    shippingMethod: shippingMethod,
                                    agreeToTerms: agreeToTerms,
                                    productIDs: productIDs,
                                    rewardsPoints: rewardsPoints,
                                    totalPrice: totalPrice
                                )//orderItem
                                
                                self.orderItems.append(orderItem)
                            }//if
                        }//if
                    }//for
                }//async
            }//if
        }//getDocument
    }//fetchUserOrders
    
    public func createNewOrder(_ orderItem: OrderItem) {
        let documentId = "\(self.user.uid)|\(Date().timeIntervalSince1970)"
        
        self.database.collection("orders").document(documentId).setData([
            "userId": self.user.uid,
            "email": orderItem.email,
            "receiveEmailUpdates": orderItem.receiveEmailUpdates,
            "countryOrRegion": orderItem.countryOrRegion,
            "firstName": orderItem.firstName,
            "lastName": orderItem.lastName,
            "company": orderItem.company,
            "address": orderItem.address,
            "apartementOrSuite": orderItem.apartmentOrSuite,
            "city": orderItem.city,
            "zipCode": orderItem.zipCode,
            "state": orderItem.state,
            "phoneNumber": orderItem.phoneNumber,
            "receiveTextUpdates": orderItem.receiveTextUpdates,
            "shippingMethod": orderItem.shippingMethod,
            "productIDs": orderItem.productIDs,
            "agreeToTerms": orderItem.agreeToTerms,
            "rewardsPoints": orderItem.rewardsPoints,
            "totalPrice": orderItem.totalPrice
        ]) { error in
            if let error = error {
                print("Error Caught - Error while updating a user profile field.")
                print("Error Details - \(error.localizedDescription)")
                
                return
            }//if
        }//setData
    }//createNewOrder
}//OrderHandler
