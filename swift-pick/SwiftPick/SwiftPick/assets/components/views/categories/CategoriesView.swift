import SwiftUI

public struct CategoriesView: View {
    @State private var isLoading: Bool = true
    
    @Binding public var selectedTab: TabViews
    @Binding public var viewFavorites: Bool
    
    public let requestHandler: RequestHandler
    public var cartItems: [CartItem]
    
    public var body: some View {
        let categories = self.requestHandler.data["categories"] as? Categories
        let collections = self.requestHandler.data["collections"] as? Collections
        let products = self.requestHandler.data["products"] as? Products
        
        if let categories, let collections, let products {
            CategoriesListView(
                selectedTab: self.$selectedTab,
                viewFavorites: self.$viewFavorites,
                cartItems: self.cartItems,
                categories: categories.data,
                collections: collections.data,
                products: products.data
            )//CategoriesListView
        }//if
    }//body
}//CategoriesView

#Preview {
    MainView()
}
