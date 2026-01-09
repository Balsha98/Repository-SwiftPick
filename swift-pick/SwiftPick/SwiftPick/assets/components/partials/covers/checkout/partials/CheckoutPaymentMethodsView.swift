import SwiftUI

public struct CheckoutPaymentMethodsView: View {
    @State private var cardNumber: String = ""
    @State private var cardExpirationDate: String = ""
    @State private var cardSecurityCode: String = ""
    @State private var cardHolderName: String = ""
    
    @Binding public var selectedMethod: PaymentMethods
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Payment Method")
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
                                self.selectedMethod = .creditCard
                            }//withAnimation
                        } label: {
                            HStack {
                                Image(systemName: self.selectedMethod == .creditCard ? "circle.circle.fill" : "circle")
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color.primary)
                                //Image
                                
                                Text("Credit Card")
                                    .font(.system(size: 14))
                                //Text
                            }//HStack
                            
                            Spacer()
                        }//Button
                        .padding(12)
                        
                        if self.selectedMethod == .creditCard {
                            Rectangle()
                                .fill(Color.primary)
                                .frame(height: 2)
                            //Rectangle
                            
                            VStack(alignment: .leading, spacing: 12) {
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$cardNumber,
                                    prompt: "Card Number",
                                    keyboard: .numberPad
                                )//CheckoutDetailsTextFieldRowView
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$cardExpirationDate,
                                    prompt: "Expiration Date",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$cardSecurityCode,
                                    prompt: "Security Code",
                                    keyboard: .numberPad
                                )//CheckoutDetailsTextFieldRowView
                                
                                CheckoutDetailsTextFieldRowView(
                                    text: self.$cardHolderName,
                                    prompt: "Cardholder Name",
                                    keyboard: .default
                                )//CheckoutDetailsTextFieldRowView
                            }//VStack
                            .padding()
                        }//if
                    }//VStack
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Button {
                            withAnimation {
                                self.selectedMethod = .payPal
                            }//withAnimation
                        } label: {
                            HStack {
                                Image(systemName: self.selectedMethod == .payPal ? "circle.circle.fill" : "circle")
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color.primary)
                                //Image
                                
                                Text("PayPal")
                                    .font(.system(size: 14))
                                //Text
                            }//HStack
                            
                            Spacer()
                        }//Button
                        .padding(12)
                        
                        if self.selectedMethod == .payPal {
                            // TODO: Could implement separate logic for PayPal.
                        }//if
                    }//VStack
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Button {
                            withAnimation {
                                self.selectedMethod = .cashApp
                            }//withAnimation
                        } label: {
                            HStack {
                                Image(systemName: self.selectedMethod == .cashApp ? "circle.circle.fill" : "circle")
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color.primary)
                                //Image
                                
                                Text("CashApp")
                                    .font(.system(size: 14))
                                //Text
                            }//HStack
                            
                            Spacer()
                        }//Button
                        .padding(12)
                        
                        if self.selectedMethod == .cashApp {
                            // TODO: Could implement separate logic for CashApp.
                        }//if
                    }//VStack
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Button {
                            withAnimation {
                                self.selectedMethod = .zelle
                            }//withAnimation
                        } label: {
                            HStack {
                                Image(systemName: self.selectedMethod == .zelle ? "circle.circle.fill" : "circle")
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color.primary)
                                //Image
                                
                                Text("Zelle")
                                    .font(.system(size: 14))
                                //Text
                            }//HStack
                            
                            Spacer()
                        }//Button
                        .padding(12)
                        
                        if self.selectedMethod == .zelle {
                            // TODO: Could implement separate logic for Zelle.
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
}//CheckoutPaymentMethodsView
