import SwiftUI

public struct CheckoutBillingAddressView: View {
    @State public var selectedOption: BillingOptions = .shipping
    
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
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Billing Address")
                    .font(.title2)
                    .fontWeight(.semibold)
                //Text
                
                Spacer()
            }//HStack
            
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Button {
                            withAnimation {
                                self.selectedOption = .shipping
                            }//withAnimation
                        } label: {
                            HStack {
                                Image(systemName: self.selectedOption == .shipping ? "circle.circle.fill" : "circle")
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color.primary)
                                //Image
                                
                                Text("Same as Shipping Address")
                                    .font(.system(size: 14))
                                //Text
                            }//HStack
                            
                            Spacer()
                        }//Button
                        .padding(12)
                    }//VStack
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Button {
                            withAnimation {
                                self.selectedOption = .different
                            }//withAnimation
                        } label: {
                            HStack {
                                Image(systemName: self.selectedOption == .different ? "circle.circle.fill" : "circle")
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color.primary)
                                //Image
                                
                                Text("Use a Different Address")
                                    .font(.system(size: 14))
                                //Text
                            }//HStack
                            
                            Spacer()
                        }//Button
                        .padding(12)
                        
                        if self.selectedOption == .different {
                            Rectangle()
                                .fill(Color.primary)
                                .frame(height: 2)
                            //Rectangle
                            
                            VStack(alignment: .leading, spacing: 12) {
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$countryOrRegion,
                                    prompt: "Country/Region",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                                
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
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$company,
                                    prompt: "Company (Optional)",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$address,
                                    prompt: "Address",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$apartmentOrSuite,
                                    prompt: "Apartment (Optional)",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                                
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
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$zipCode,
                                    prompt: "Zip Code",
                                    keyboard: .numberPad
                                )//CheckoutDetailsTextFieldRowView
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$phoneNumber,
                                    prompt: "Phone",
                                    keyboard: .phonePad
                                )//CheckoutDetailsTextFieldRowView
                            }//VStack
                            .padding()
                        }//if
                    }//VStack
                }//VStack
                .foregroundStyle(.black)
                .background(.white)
                .cornerRadius(4)
            }//ZStack
            .shadow(
                color: .black.opacity(0.2),
                radius: 4, x: 0, y: 4
            )//shadow
        }//VStack
    }//body
}//CheckoutBillingAddressView
