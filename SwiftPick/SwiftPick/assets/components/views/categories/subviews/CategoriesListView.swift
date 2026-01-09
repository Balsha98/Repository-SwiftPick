import SwiftUI

public struct CategoriesListView: View {
    @Binding public var selectedTab: TabViews
    @Binding public var viewFavorites: Bool
    
    public let cartItems: [CartItem]
    public let categories: [Category]
    public let collections: [Collection]
    public let products: [Product]
    
    public var body: some View {
        NavigationStack {
            TopbarMenuView(
                selectedTab: self.$selectedTab,
                viewFavorites: self.$viewFavorites,
                cartItems: self.cartItems
            )//TopbarMenuView
            
            List {
                ForEach(self.categories) { category in
                    let filteredCollections = self.collections.filter({
                        $0.categoryId == category.categoryId
                    })//filter
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text(category.categoryName)
                                .font(.title2)
                                .fontWeight(.bold)
                            //Text
                                
                            Spacer()
                            
                            ZStack(alignment: .bottomTrailing) {
                                NavigationLink {
                                    CollectionsListView(
                                        category: category,
                                        collections: filteredCollections,
                                        products: self.products
                                    )//CollectionsListView
                                } label: {
                                    EmptyView()
                                }//NavigationLink
                                .opacity(0)
                                .zIndex(2)
                                
                                Image(systemName: "chevron.right")
                                    .font(.title3)
                                    .zIndex(1)
                                //Image
                            }//ZStack
                        }//HStack
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 16) {
                                ForEach (filteredCollections) { collection in
                                    NavigationLink {
                                        ProductsListView(
                                            products: self.products.filter({
                                                $0.categoryId == category.categoryId &&
                                                $0.collectionId == collection.collectionId
                                            }).sorted(by: { $0.productName < $1.productName }),
                                            collectionName: collection.collectionName
                                        )//ProductsListView
                                    } label: {
                                        VStack {
                                            HStack {
                                                Text(collection.collectionName)
                                                    .font(.title3)
                                                    .fontWeight(.semibold)
                                                    .cornerRadius(4)
                                                //Text
                                                
                                                Spacer()
                                            }//HStack
                                            
                                            Spacer()
                                            
                                            HStack(alignment: .bottom) {
                                                Rectangle()
                                                    .fill(.white)
                                                    .frame(width: 64, height: 2)
                                                //Rectangle
                                                
                                                Spacer()
                                                
                                                Image("logo.valuetainment.portrait.inverted")
                                                    .resizable()
                                                    .frame(width: 48, height: 48)
                                                //Image
                                            }//HStack
                                        }//VStack
                                        .frame(width: 240, height: 120)
                                        .padding()
                                        .foregroundStyle(.white)
                                        .background(Color.primary)
                                        .cornerRadius(4)
                                    }//NavigationLink
                                }//ForEach
                                .shadow(
                                    color: .black.opacity(0.2),
                                    radius: 4, x: 0, y: 4
                                )//shadow
                            }//HStack
                        }//ScrollView
                        .scrollIndicators(.hidden)
                        .scrollClipDisabled()
                    }//VStack
                }//ForEach
                .listRowSeparator(.hidden)
            }//List
            .listStyle(.plain)
            .navigationTitle("")
            .scrollIndicators(.hidden)
        }//NavigationStack
    }//body
}//CategoriesListView
