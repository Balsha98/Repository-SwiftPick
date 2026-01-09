import SwiftUI
import FirebaseAuth

public struct MainTabView: View {
    @State private var isLoading: Bool = true
    @State private var selectedTab: TabViews = .home
    @State private var viewFavorites: Bool = false
    
    @Binding public var user: User?
    
    public let requestHandler: RequestHandler = RequestHandler()
    public let profileHandler: ProfileHandler = ProfileHandler()
    public let reviewHandler: ReviewHandler = ReviewHandler()
    public let orderHandler: OrderHandler = OrderHandler()
    public let cartHandler: CartHandler = CartHandler()
    
    private var cartItems: [CartItem] {
        return self.cartHandler.cartItems
    }//cartItems
    
    private var cartIcon: String {
        return self.cartItems.isEmpty ? "cart.fill" : "cart.badge.clock.fill"
    }//cartIcon
    
    public var body: some View {
        ZStack {
            if self.isLoading {
                AppLoadingView()
            } else {
                TabView(selection: self.$selectedTab) {
                    Tab("Home", systemImage: "house.fill", value: .home) {
                        HomeView(
                            selectedTab: self.$selectedTab,
                            viewFavorites: self.$viewFavorites,
                            requestHandler: self.requestHandler,
                            profileHandler: self.profileHandler,
                            orderHandler: self.orderHandler,
                            cartItems: self.cartItems
                        )//HomeView
                    }//Tab
                    
                    Tab("Categories", systemImage: "list.dash", value: .categories) {
                        CategoriesView(
                            selectedTab: self.$selectedTab,
                            viewFavorites: self.$viewFavorites,
                            requestHandler: self.requestHandler,
                            cartItems: self.cartItems
                        )//CategoriesView
                    }//Tab
                    
                    Tab("Cart", systemImage: self.cartIcon, value: .cart) {
                        CartView(
                            selectedTab: self.$selectedTab,
                            viewFavorites: self.$viewFavorites,
                            cartHandler: self.cartHandler
                        )//CartView
                    }//Tab
                    
                    Tab("Reviews", systemImage: "star.bubble.fill", value: .reviews) {
                        ReviewsView(
                            selectedTab: self.$selectedTab,
                            viewFavorites: self.$viewFavorites,
                            requestHandler: self.requestHandler,
                            reviewHandler: self.reviewHandler,
                            cartItems: self.cartItems
                        )//ReviewsView
                    }//Tab
                    
                    Tab("Profile", systemImage: "person.fill", value: .profile) {
                        ProfileView(
                            selectedTab: self.$selectedTab,
                            viewFavorites: self.$viewFavorites,
                            user: self.$user,
                            profileHandler: self.profileHandler,
                            orderHandler: self.orderHandler,
                            cartItems: self.cartItems
                        )//ProfileView
                    }//Tab
                }//TabView
                .tint(Color.primary)
                .fullScreenCover(isPresented: self.$viewFavorites) {
                    FavoritesFullScreenView(
                        selectedTab: self.$selectedTab,
                        viewFavorites: self.$viewFavorites,
                        requestHandler: self.requestHandler
                    )//FavoritesFullScreenView
                }//fullScreenCover
                .onAppear {
                    self.cartHandler.fetchCartItems()
                }//onAppear
            }//if
        }//ZStack
        .onAppear {
            // try? Auth.auth().signOut()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isLoading = false
                }//withAnimation
            }//asyncAfter
        }//onAppear
        .task {
            await self.requestHandler.fetchAll(for: "categories")
            await self.requestHandler.fetchAll(for: "collections")
            await self.requestHandler.fetchAll(for: "podcasts")
            await self.requestHandler.fetchAll(for: "products")
            await self.requestHandler.fetchAll(for: "stores")
        }//task
    }//body
}//MainTabView

#Preview {
    MainView()
}
