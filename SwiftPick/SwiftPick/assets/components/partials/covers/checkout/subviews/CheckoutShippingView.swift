import SwiftUI

public struct CheckoutShippingView: View {
    @State private var selectedMethod: ShippingMethods = .free
    @State private var shippingMethod: String = ""
    
    @Binding public var navPath: NavigationPath
    @Binding public var selectedTab: TabViews
    @Binding public var email: String
    @Binding public var receiveEmailUpdates: Bool
    @Binding public var countryOrRegion: String
    @Binding public var firstName: String
    @Binding public var lastName: String
    @Binding public var company: String
    @Binding public var address: String
    @Binding public var apartmentOrSuite: String
    @Binding public var city: String
    @Binding public var zipCode: String
    @Binding public var state: String
    @Binding public var phoneNumber: String
    @Binding public var receiveTextUpdates: Bool
    
    public let shippingCases: [ShippingMethods: ShippingCase] = ShippingCases().cases
    
    public let productIDs: [Int]
    public let rewardsPoints: Int
    public let totalPrice: Double
    
    private var totalPriceAfterShipping: Double {
        if let shippingCase = self.shippingCases[self.selectedMethod] {
            return self.totalPrice + shippingCase.cost
        }//if
        
        return self.totalPrice
    }//totalPriceAfterShipping
    
    public var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 24) {
                    CheckoutShippingOverviewView(
                        email: self.email,
                        countryOrRegion: self.countryOrRegion,
                        address: self.address,
                        city: self.city,
                        zipCode: self.zipCode,
                        state: self.state
                    )//CheckoutShippingOverviewView
                    
                    CheckoutShippingMethodsView(
                        selectedMethod: self.$selectedMethod
                    )//CheckoutShippingMethodsView
                }//VStack
                
                Spacer()
                
                NavigationLink {
                    CheckoutPaymentView(
                        navPath: self.$navPath,
                        selectedTab: self.$selectedTab,
                        email: self.$email,
                        receiveEmailUpdates: self.$receiveEmailUpdates,
                        countryOrRegion: self.$countryOrRegion,
                        firstName: self.$firstName,
                        lastName: self.$lastName,
                        company: self.$company,
                        address: self.$address,
                        apartmentOrSuite: self.$apartmentOrSuite,
                        city: self.$city,
                        zipCode: self.$zipCode,
                        state: self.$state,
                        phoneNumber: self.$phoneNumber,
                        receiveTextUpdates: self.$receiveTextUpdates,
                        shippingMethod: self.$shippingMethod,
                        productIDs: self.productIDs,
                        rewardsPoints: self.rewardsPoints,
                        totalPrice: self.totalPriceAfterShipping
                    )//CheckoutPaymentView
                } label: {
                    Text("Continue to Payment")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.primary)
                        .cornerRadius(4)
                    //Text
                }//Button
            }//VStack
            .padding(.vertical)
            .padding(.horizontal, 24)
            .navigationTitle("Shipping")
            .navigationBarTitleDisplayMode(.inline)
        }//NavigationStack
        .safeAreaInset(edge: .bottom) {
            CheckoutSafeAreaCalcView(totalPrice: self.totalPriceAfterShipping)
        }//safeAreaInset
    }//body
}//CheckoutShippingView
