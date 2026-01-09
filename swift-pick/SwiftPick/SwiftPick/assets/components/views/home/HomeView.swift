import SwiftUI

public struct HomeView: View {
    @State private var isLoading: Bool = true
    @State private var viewStores: Bool = false
    
    @Binding public var selectedTab: TabViews
    @Binding public var viewFavorites: Bool
    
    public var requestHandler: RequestHandler
    public var profileHandler: ProfileHandler
    public var orderHandler: OrderHandler
    public var cartItems: [CartItem]
    
    private var rewardsPoints: Int {
        if let _ = self.profileHandler.userProfile {
            return self.orderHandler.orderItems.reduce(0) { start, item in
                return start + item.rewardsPoints
            }//return
        }//if
        
        return 0
    }//rewardsPoints
    
    public var body: some View {
        VStack {
            TopbarMenuView(
                selectedTab: self.$selectedTab,
                viewFavorites: self.$viewFavorites,
                cartItems: self.cartItems
            )//TopbarMenuView
            
            let categories = self.requestHandler.data["categories"] as? Categories
            let podcasts = self.requestHandler.data["podcasts"] as? Podcasts
            let stores = self.requestHandler.data["stores"] as? Stores
            
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    WelcomeView()
                    
                    TrendingScrollView(selectedTab: self.$selectedTab)
                    
                    MissionStatementView()
                    
                    CategoriesScrollView(
                        selectedTab: self.$selectedTab,
                        categories: categories
                    )//CategoriesScrollView
                    
                    StoresScrollView(
                        viewStores: self.$viewStores,
                        stores: stores
                    )//StoresScrollView
                    
                    PodcastScrollView(
                        rewardsPoints: self.rewardsPoints,
                        podcasts: podcasts
                    )//PodcastScrollView
                }//VStack
                .padding(.horizontal)
            }//ScrollView
            .scrollIndicators(.hidden)
        }//VStack
        .fullScreenCover(isPresented: self.$viewStores) {
            StoresFullScreenView(
                viewStores: self.$viewStores,
                requestHandler: self.requestHandler
            )//StoresFullScreenView
        }//fullScreenCover
        .onAppear {
            self.profileHandler.fetchUserProfile()
            self.orderHandler.fetchUserOrders()
        }//onAppear
    }//body
}//HomeView

#Preview {
    MainView()
}
