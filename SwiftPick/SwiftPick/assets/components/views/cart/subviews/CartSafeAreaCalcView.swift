import SwiftUI

public struct CartSafeAreaCalcView: View {
    @State private var viewCheckout: Bool = false
    
    @Binding public var selectedTab: TabViews
    
    public let cartItems: [CartItem]
    
    public let productIDs: [Int]
    public let rewardsPoints: Int
    public let price: Double
    public let shipping: Double
    public let tax: Double
    public let total: Double
    
    public var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                HStack {
                    Text("Price:")
                    
                    Spacer()
                    
                    Text(String(format: "$%.2f", self.price))
                }//HStack

                HStack {
                    Text("Shipping:")
                    
                    Spacer()
                    
                    Text(String(format: "$%.2f", self.shipping))
                }//HStack
                
                HStack {
                    Text("Tax:")
                    
                    Spacer()
                    
                    Text(String(format: "%.2f%%", self.tax))
                }//HStack
            }//VStack
            .fontWeight(.semibold)
            
            Rectangle()
                .fill(Color.primary)
                .frame(height: 2)
                .cornerRadius(4)
            //Rectangle
            
            HStack {
                Text("Total:")
                
                Spacer()
                
                Text(String(format: "$%.2f", self.total))
            }//HStack
            .font(.title3)
            .fontWeight(.bold)
            
            if !self.cartItems.isEmpty {
                Button {
                    self.viewCheckout = true
                } label: {
                    Text("Checkout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.primary)
                        .cornerRadius(4)
                    //Text
                }//Button
            }//if
        }//VStack
        .padding()
        .foregroundStyle(.black)
        .background(.white)
        .fullScreenCover(isPresented: self.$viewCheckout) {
            CheckoutFullScreenView(
                selectedTab: self.$selectedTab,
                viewCheckout: self.$viewCheckout,
                productIDs: self.productIDs,
                rewardsPoints: self.rewardsPoints,
                totalPrice: self.total
            )//CheckoutFullScreenView
        }//fullScreenCover
    }//body
}//CartSafeAreaCalcView
