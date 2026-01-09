import SwiftUI
import SwiftData

public struct CartView: View {
    @Binding public var selectedTab: TabViews
    @Binding public var viewFavorites: Bool
    
    public let cartHandler: CartHandler
    
    private var cartItems: [CartItem] {
        return self.cartHandler.cartItems
    }//cartItems
    
    private var productIDs: [Int] {
        if !self.cartItems.isEmpty {
            return self.cartItems.map({ $0.productId })
        }//if
        
        return []
    }//productIDs
    
    private var rewardsPoints: Int {
        if !self.cartItems.isEmpty {
            return self.cartItems.reduce(0) { start, item in
                return start + item.productRewardPoints
            }//return
        }//if
        
        return 0
    }//rewardsPoints
    
    private var price: Double {
        return self.cartItems.reduce(0) { start, item in
            return start + (item.productPrice * Double(item.productQuantity))
        }//reduce
    }//price
    
    private var shipping: Double {
        switch(self.price) {
        case 0:
            return 0
        case 0...100:
            return 25
        default:
            return 0
        }//switch
    }//shipping
    
    private var priceAfterShipping: Double {
        return self.price + self.shipping
    }//priceAfterShipping
    
    private var tax: Double {
        switch(self.priceAfterShipping) {
        case 0:
            return 0
        case 0...50:
            return 5
        case 0...100:
            return 10
        default:
            return 15
        }//switch
    }//tax
    
    private var total: Double {
        return self.priceAfterShipping + ((self.priceAfterShipping) * (self.tax / 100))
    }//total
    
    public var body: some View {
        VStack {
            TopbarMenuView(
                selectedTab: self.$selectedTab,
                viewFavorites: self.$viewFavorites,
                cartItems: self.cartItems
            )//TopbarMenuView
            
            if !self.cartItems.isEmpty {
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(self.cartItems) { cartItem in
                            CartItemView(
                                cartHandler: self.cartHandler,
                                cartItem: cartItem
                            )//CartItemView
                        }//ForEach
                        .listRowSeparator(.hidden)
                    }//VStack
                    .padding()
                }//ScrollView
                .scrollIndicators(.hidden)
            } else {
                Spacer()
                
                Text("Your cart is empty.")
                    .foregroundStyle(Color.primary)
                //Text
            }//if
            
            Spacer()
        }//VStack
        .safeAreaInset(edge: .bottom) {
            CartSafeAreaCalcView(
                selectedTab: self.$selectedTab,                cartItems: self.cartItems,
                productIDs: self.productIDs,
                rewardsPoints: self.rewardsPoints,
                price: self.price,
                shipping: self.shipping,
                tax: self.tax,
                total: self.total
            )//CartSafeAreaCalcView
        }//safeAreaInset
        .onAppear {
            withAnimation {
                self.cartHandler.fetchCartItems()
            }//withAnimation
        }//onAppear
    }//body
}//CartView

#Preview {
    MainView()
}
