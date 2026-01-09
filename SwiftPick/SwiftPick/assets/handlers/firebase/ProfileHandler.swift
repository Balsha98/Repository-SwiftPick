import Foundation
import Firebase
import FirebaseAuth

@Observable
public class ProfileHandler {
    public var userProfile: UserProfile?
    
    private let database: Firestore = Firestore.firestore()
    
    private let user: User = Auth.auth().currentUser!
    
    public func fetchUserProfile() {
        let collection = self.database.collection("users")
        
        let document = collection.document(self.user.uid)
        
        document.getDocument { document, error in
            if let error = error {
                print("Error Caught - Error while fetching the user profile.")
                print("Error Details - \(error.localizedDescription)")
                
                return
            }//if
            
            if let document = document {
                if let data = document.data() {
                    if !data.isEmpty {
                        let firstName = data["firstName"] as? String ?? ""
                        let lastName = data["lastName"] as? String ?? ""
                        let dateOfBirth = data["dateOfBirth"] as? String ?? Date().formatted(date: .numeric, time: .omitted)
                        let gender = data["gender"] as? String ?? ""
                        let age = data["age"] as? Int ?? 0
                        let countryOfOrigin = data["countryOfOrigin"] as? String ?? ""
                        let phoneNumber = data["phoneNumber"] as? String ?? ""
                        let pbdSubscriber = data["pbdSubscriber"] as? Bool ?? false
                        
                        DispatchQueue.main.async {
                            self.userProfile = UserProfile(
                                userId: self.user.uid,
                                firstName: firstName,
                                lastName: lastName,
                                dateOfBirth: dateOfBirth,
                                gender: gender,
                                age: age,
                                countryOfOrigin: countryOfOrigin,
                                email: self.user.email!,
                                phoneNumber: phoneNumber,
                                pbdSubscriber: pbdSubscriber
                            )//UserProfile
                        }//async
                    }//if
                }//if
            }//if
        }//getDocument
    }//fetchUserProfile
    
    public func updateUserProfileForFields(with data: [String: Any], exists: Bool) {
        self.database.collection("users").document(self.user.uid).setData(data, merge: exists) { error in
            if let error = error {
                print("Error Caught - Error while updating a user profile field.")
                print("Error Details - \(error.localizedDescription)")
                
                return
            }//if
        }//setData
    }//updateUserProfileForFields
    
    public func deleteUserProfile(_ productId: Int) {
        let collection = self.database.collection("users")
        
        let document = collection.document(self.user.uid)
        
        document.delete { error in
            if let error = error {
                print("Error Caught - Error while deleting a user profile.")
                print("Error Details - \(error.localizedDescription)")
                
                return
            }//if
        }//delete
    }//deleteUserProfile
}//ProfileHandler
