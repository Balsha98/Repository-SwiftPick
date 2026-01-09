import SwiftUI
import FirebaseAuth

public struct CheckoutPaymentView: View {
    @State private var viewAlert: Bool = false
    @State private var isSuccessful: Bool = false
    @State private var selectedMethod: PaymentMethods = .creditCard
    @State private var paymentMethod: String = ""
    @State private var agreeToTerms: Bool = false
    
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
    @Binding public var shippingMethod: String
    
    public let productIDs: [Int]
    public let rewardsPoints: Int
    public let totalPrice: Double
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 24) {
                        CheckoutPaymentOverviewView(
                            email: self.email,
                            countryOrRegion: self.countryOrRegion,
                            address: self.address,
                            city: self.city,
                            zipCode: self.zipCode,
                            state: self.state,
                            shippingMethod: self.shippingMethod
                        )//CheckoutPaymentOverviewView
                        
                        CheckoutPaymentMethodsView(selectedMethod: self.$selectedMethod)
                        
                        CheckoutBillingAddressView(
                            countryOrRegion: self.$countryOrRegion,
                            firstName: self.$firstName,
                            lastName: self.$lastName,
                            company: self.$company,
                            address: self.$address,
                            apartmentOrSuite: self.$apartmentOrSuite,
                            city: self.$city,
                            zipCode: self.$zipCode,
                            state: self.$state,
                            phoneNumber: self.$phoneNumber
                        )//CheckoutBillingAddressView
                        
                        HStack(spacing: 4) {
                            Button {
                                self.agreeToTerms.toggle()
                            } label: {
                                Image(systemName: self.agreeToTerms ? "checkmark.circle.fill" : "circle")
                                    .font(.system(size: 24))
                                    .foregroundStyle(self.agreeToTerms ? .green : .black)
                                //Image
                            }//Button
                            
                            Button {
                                UIApplication.shared.open(URL(string: "https://vtmerch.com/policies/terms-of-service")!)
                            } label: {
                                Text("I agree to the Terms of Service.")
                                    .foregroundStyle(.blue)
                                    .underline()
                            }//Button
                            
                            Spacer()
                        }//HStack
                    }//VStack
                    
                    Spacer()
                    
                    Button {
                        OrderHandler().createNewOrder(OrderItem(
                            userId: Auth.auth().currentUser!.uid, // TODO: Make this better.
                            email: self.email,
                            receiveEmailUpdates: self.receiveEmailUpdates,
                            countryOrRegion: self.countryOrRegion,
                            firstName: self.firstName,
                            lastName: self.lastName,
                            company: self.company,
                            address: self.address,
                            apartmentOrSuite: self.apartmentOrSuite,
                            city: self.city,
                            zipCode: self.zipCode,
                            state: self.state,
                            phoneNumber: self.phoneNumber,
                            receiveTextUpdates: self.receiveTextUpdates,
                            shippingMethod: self.shippingMethod,
                            agreeToTerms: self.agreeToTerms,
                            productIDs: self.productIDs,
                            rewardsPoints: self.rewardsPoints,
                            totalPrice: self.totalPrice
                        ))//createNewOrder
                        
                        if !self.productIDs.isEmpty {
                            for productId in productIDs {
                                CartHandler().deleteCartItem(productId)
                            }//for
                        }//if
                        
                        self.viewAlert = true
                    } label: {
                        Text("Confirm Payment")
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
                .navigationTitle("Payment")
                .navigationBarTitleDisplayMode(.inline)
                .scrollIndicators(.hidden)
            }//ScrollView
        }//NavigationStack
        .safeAreaInset(edge: .bottom) {
            CheckoutSafeAreaCalcView(totalPrice: self.totalPrice)
        }//safeAreaInset
        .sheet(isPresented: self.$viewAlert) {
            AlertSheetView(
                viewAlert: self.$viewAlert,
                icon: "check",
                heading: "Order Successful",
                message: "Your order was processed successfully.",
            ) {
                self.navPath = NavigationPath()
                
                self.selectedTab = .profile
                
                self.viewAlert = false
            }//AlertSheetView
        }//sheet
    }//body
}//CheckoutPaymentView
