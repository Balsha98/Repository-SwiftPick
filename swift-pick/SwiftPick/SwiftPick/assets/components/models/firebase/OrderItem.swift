public class OrderItem {
    public let userId: String
    public let email: String
    public let receiveEmailUpdates: Bool
    public let countryOrRegion: String
    public let firstName: String
    public let lastName: String
    public let company: String
    public let address: String
    public let apartmentOrSuite: String
    public let city: String
    public let zipCode: String
    public let state: String
    public let phoneNumber: String
    public let receiveTextUpdates: Bool
    public let shippingMethod: String
    public let agreeToTerms: Bool
    public let productIDs: [Int]
    public let rewardsPoints: Int
    public let totalPrice: Double
    
    public init(
        userId: String,
        email: String,
        receiveEmailUpdates: Bool,
        countryOrRegion: String,
        firstName: String,
        lastName: String,
        company: String,
        address: String,
        apartmentOrSuite: String,
        city: String,
        zipCode: String,
        state: String,
        phoneNumber: String,
        receiveTextUpdates: Bool,
        shippingMethod: String,
        agreeToTerms: Bool,
        productIDs: [Int],
        rewardsPoints: Int,
        totalPrice: Double
    ) {
        self.userId = userId
        self.email = email
        self.receiveEmailUpdates = receiveEmailUpdates
        self.countryOrRegion = countryOrRegion
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.address = address
        self.apartmentOrSuite = apartmentOrSuite
        self.city = city
        self.zipCode = zipCode
        self.state = state
        self.phoneNumber = phoneNumber
        self.receiveTextUpdates = receiveTextUpdates
        self.shippingMethod = shippingMethod
        self.agreeToTerms = agreeToTerms
        self.productIDs = productIDs
        self.rewardsPoints = rewardsPoints
        self.totalPrice = totalPrice
    }//init
}//OrderItem
