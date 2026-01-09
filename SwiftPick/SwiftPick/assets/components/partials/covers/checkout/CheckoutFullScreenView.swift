import SwiftUI

public struct CheckoutFullScreenView: View {
    @State private var navPath: NavigationPath = NavigationPath()
    @State private var email: String = ""
    @State private var receiveEmailUpdates: Bool = false
    @State private var countryOrRegion: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var company: String = ""
    @State private var address: String = ""
    @State private var apartmentOrSuite: String = ""
    @State private var city: String = ""
    @State private var zipCode: String = ""
    @State private var state: String = ""
    @State private var phoneNumber: String = ""
    @State private var receiveTextUpdates: Bool = false
    
    @Binding public var selectedTab: TabViews
    @Binding public var viewCheckout: Bool
    
    public let productIDs: [Int]
    public let rewardsPoints: Int
    public let totalPrice: Double
    
    public var body: some View {
        NavigationStack(path: self.$navPath) {
            HStack {
                Image(systemName: "bag.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(Color.primary)
                //Image
                
                Spacer()
                
                Button {
                    self.viewCheckout = false
                } label: {
                    VStack {
                        Image(systemName: "chevron.down")
                            .frame(width: 32, height: 32)
                            .foregroundStyle(Color.primary)
                        //Image
                    }//VStack
                }//Button
            }//HStack
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            
            CheckoutDetailsView(
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
                productIDs: self.productIDs,
                rewardsPoints: self.rewardsPoints,
                totalPrice: self.totalPrice
            )//CheckoutDetailsView
            
            Spacer()
        }//NavigationStack
    }//body
}//CheckoutFullScreenView

#Preview {
    MainView()
}
