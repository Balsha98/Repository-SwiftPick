public class UserProfile {
    public var userId: String
    public var firstName: String?
    public var lastName: String?
    public var dateOfBirth: String?
    public var gender: String?
    public var age: Int?
    public var countryOfOrigin: String?
    public var email: String
    public var phoneNumber: String?
    public var pbdSubscriber: Bool?
    public var totalPoints: Int = 0
    public var totalOrders: Int = 0
    
    public init(
        userId: String,
        firstName: String?,
        lastName: String?,
        dateOfBirth: String?,
        gender: String?,
        age: Int?,
        countryOfOrigin: String?,
        email: String,
        phoneNumber: String?,
        pbdSubscriber: Bool?
    ) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.age = age
        self.countryOfOrigin = countryOfOrigin
        self.email = email
        self.phoneNumber = phoneNumber
        self.pbdSubscriber = pbdSubscriber
    }//init
}//UserProfile
