import SwiftUI
import FirebaseAuth

public struct ProfileView: View {
    @State private var viewOrders: Bool = false
    
    @Binding public var selectedTab: TabViews
    @Binding public var viewFavorites: Bool
    @Binding public var user: User?
    
    public let profileHandler: ProfileHandler
    public let orderHandler: OrderHandler
    public var cartItems: [CartItem]
    
    private var userProfile: UserProfile? {
        return self.profileHandler.userProfile
    }//userProfile
    
    public var body: some View {
        VStack {
            TopbarMenuView(
                selectedTab: self.$selectedTab,
                viewFavorites: self.$viewFavorites,
                cartItems: self.cartItems
            )//TopbarMenuView
            
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    if let userProfile = self.userProfile {
                        ProfileOverviewView(
                            viewOrders: self.$viewOrders,
                            userProfile: userProfile,
                            orderHandler: self.orderHandler
                        )//ProfileOverviewView
                        
                        AccountDetailsView(
                            profileHandler: self.profileHandler,
                            userProfile: userProfile
                        )//AccountDetailsView
                        
                        AdditionalDetailsView(
                            profileHandler: self.profileHandler,
                            userProfile: userProfile
                        )//AdditionalDetailsView
                        
                        AccountSettingsView(
                            user: self.$user
                        )//AccountSettingsView
                    }//if
                }//VStack
                .padding()
            }//ScrollView
            .scrollIndicators(.hidden)
        }//VStack
        .sheet(isPresented: self.$viewOrders) {
            OrdersSheetView(
                viewOrders: self.$viewOrders,
                selectedTab: self.$selectedTab
            )//OrdersSheetView
        }//sheet
        .onAppear {
            self.profileHandler.fetchUserProfile()
        }//onAppear
    }//body
}//ProfileView

#Preview {
    MainView()
}
