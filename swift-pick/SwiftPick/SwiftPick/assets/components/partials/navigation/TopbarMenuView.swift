import SwiftUI
import SwiftData

public struct TopbarMenuView: View {
    @Query private var favoriteItems: [FavoriteItem]
    
    @Binding public var selectedTab: TabViews
    @Binding public var viewFavorites: Bool
    
    public var cartItems: [CartItem]
    
    private var heartIcon: String {
        return self.favoriteItems.isEmpty ? "heart" : "heart.fill"
    }//heartIcon
    
    private var cartIcon: String {
        return self.cartItems.isEmpty ? "cart.fill" : "cart.badge.clock.fill"
    }//cartIcon
    
    public var body: some View {
        HStack {
            Button {
                self.selectedTab = .home
            } label: {
                Image("logo.swift.pick")
                    .resizable()
                    .frame(width: 48, height: 48)
                //Image
            }//Button
            
            Spacer()
            
            HStack(spacing: 8) {
                Button {
                    self.viewFavorites = true
                } label: {
                    Image(systemName: self.heartIcon)
                        .opacity(self.viewFavorites ? 0.4 : 1)
                    //Image
                }//Button
                
                Button {
                    self.selectedTab = .cart
                } label: {
                    Image(systemName: self.cartIcon)
                        .opacity(self.selectedTab == .cart ? 0.4 : 1)
                    //Image
                }//Button
            }//HStack
            .foregroundStyle(Color.primary)
        }//HStack
        .padding(.top, 0)
        .padding(.horizontal)
        .padding(.bottom)
        .font(.title)
    }//body
}//TopMenuView
