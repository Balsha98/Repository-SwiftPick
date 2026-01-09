import SwiftUI

public struct CheckoutDetailsView: View {
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
    
    public let productIDs: [Int]
    public let rewardsPoints: Int
    public let totalPrice: Double
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Contact")
                                .font(.title2)
                                .fontWeight(.semibold)
                            //Text
                            
                            Spacer()
                        }//HStack
                        
                        CheckoutDetailsTextFieldRowView(
                            text: self.$email,
                            prompt: "Email Address",
                            keyboard: .emailAddress
                        ) {
                            HStack(spacing: 4) {
                                Button {
                                    self.receiveEmailUpdates.toggle()
                                } label: {
                                    Image(systemName: self.receiveEmailUpdates ? "checkmark.circle.fill" : "circle")
                                        .font(.system(size: 16))
                                        .foregroundStyle(self.receiveEmailUpdates ? .green : .black)
                                    //Image
                                }//Button
                                
                                Text("I wish to receive email updates.")
                                    .font(.caption)
                                //Text
                                
                                Spacer()
                            }//HStack
                        }//CheckoutDetailsTextFieldRowView
                    }//VStack
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Shipping Address")
                                .font(.title2)
                                .fontWeight(.semibold)
                            //Text
                            
                            Spacer()
                        }//HStack
                        
                        VStack(alignment: .leading, spacing: 12) {
                            CheckoutDetailsTextFieldRowView(
                                text: self.$countryOrRegion,
                                prompt: "Country/Region",
                                keyboard: .default
                            )//CheckoutDetailsTextFieldRowView
                            
                            HStack(spacing: 12) {
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$firstName,
                                    prompt: "First Name",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$lastName,
                                    prompt: "Last Name",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                            }//HStack
                            
                            CheckoutDetailsTextFieldRowView(
                                text: self.$company,
                                prompt: "Company (Optional)",
                                keyboard: .default
                            )//CheckoutDetailsTextFieldRowView
                            
                            CheckoutDetailsTextFieldRowView(
                                text: self.$address,
                                prompt: "Address",
                                keyboard: .default
                            ) {
                                HStack(spacing: 4) {
                                    Image(systemName: "info.circle.fill")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.yellow)
                                    //Image
                                    
                                    Text("Add a house number (optional).")
                                        .font(.caption)
                                    //Text
                                    
                                    Spacer()
                                }//HStack
                                .padding(.bottom, 12)
                            }//CheckoutDetailsTextFieldRowView
                            
                            CheckoutDetailsTextFieldRowView(
                                text: self.$apartmentOrSuite,
                                prompt: "Apartment (Optional)",
                                keyboard: .default
                            )//CheckoutDetailsTextFieldRowView
                            
                            
                            HStack(spacing: 12) {
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$city,
                                    prompt: "City",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$state,
                                    prompt: "State",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                            }//HStack
                            
                            CheckoutDetailsTextFieldRowView(
                                text: self.$zipCode,
                                prompt: "Zip Code",
                                keyboard: .numberPad
                            )//CheckoutDetailsTextFieldRowView
                            
                            CheckoutDetailsTextFieldRowView(
                                text: self.$phoneNumber,
                                prompt: "Phone",
                                keyboard: .phonePad
                            ) {
                                HStack(spacing: 4) {
                                    Button {
                                        self.receiveTextUpdates.toggle()
                                    } label: {
                                        Image(systemName: self.receiveTextUpdates ? "checkmark.circle.fill" : "circle")
                                            .font(.system(size: 16))
                                            .foregroundStyle(self.receiveTextUpdates ? .green : .black)
                                        //Image
                                    }//Button
                                    
                                    Text("I wish to receive text updates.")
                                        .font(.caption)
                                    //Text
                                    
                                    Spacer()
                                }//HStack
                            }//CheckoutDetailsTextFieldRowView
                        }//VStack
                    }//VStack
                    
                    NavigationLink {
                        CheckoutShippingView(
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
                        )//CheckoutShippingView
                    } label: {
                        Text("Continue to Shipping")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.primary)
                            .cornerRadius(4)
                        //Text
                    }//Button
                }//VStack
                .padding(.horizontal, 24)
            }//ScrollView
            .scrollIndicators(.hidden)
        }//NavigationStack
    }//body
}//CheckoutDetailsView
