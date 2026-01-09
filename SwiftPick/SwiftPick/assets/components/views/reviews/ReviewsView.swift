import SwiftUI

public struct ReviewsView: View {
    @State private var reviewCases: [ReviewCase] = ReviewCases().cases
    @State private var selectedReviewIndex: Int = 0
    
    @Binding public var selectedTab: TabViews
    @Binding public var viewFavorites: Bool
    
    public let requestHandler: RequestHandler
    public let reviewHandler: ReviewHandler
    public var cartItems: [CartItem]
    
    public var body: some View {
        NavigationStack {
            TopbarMenuView(
                selectedTab: self.$selectedTab,
                viewFavorites: self.$viewFavorites,
                cartItems: self.cartItems
            )//TopbarMenuView
            
            let products = self.requestHandler.data["products"] as? Products
            
            if let products = products {
                if !products.data.isEmpty {
                    ReviewsSortingView(
                        reviewCases: self.$reviewCases,
                        selectedReviewIndex: self.$selectedReviewIndex
                    )//ReviewsSortingView
                    
                    let sortedProducts = self.filterProductsPerRating(products.data.sorted(by: { $0.productRating > $1.productRating }))
                    
                    if !sortedProducts.isEmpty {
                        List {
                            ForEach(sortedProducts) { product in
                                ZStack(alignment: .bottom) {
                                    NavigationLink {
                                        ProductReviewsView(
                                            reviewHandler: self.reviewHandler,
                                            product: product
                                        )//ProductReviewsView
                                    } label: {
                                        EmptyView()
                                    }//NavigationLink
                                    .opacity(0)
                                    .zIndex(2)
                                    
                                    HStack {
                                        if !product.productImages.isEmpty {
                                            if let firstImage = product.productImages.first {
                                                if let url = URL(string: firstImage) {
                                                    AsyncImage(url: url) { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 120, height: 120)
                                                        //Image
                                                    } placeholder: {
                                                        Image("logo.valuetainment.portrait.original")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 120, height: 120)
                                                        //Image
                                                    }//AsyncImage
                                                    .cornerRadius(4)
                                                }//if
                                            }//if
                                        }//if
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(product.productName)
                                                .fontWeight(.bold)
                                                .lineLimit(1)
                                            //Text
                                            
                                            HStack(spacing: 8) {
                                                ForEach(0..<product.productRating, id: \.self) { _ in
                                                    Image(systemName: "star.fill")
                                                        .font(.title3)
                                                        .foregroundStyle(.yellow)
                                                    //Image
                                                }//ForEach
                                            }//HStack
                                            
                                            HStack {
                                                Text(String(format: "$%.2f USD", product.productPrice))
                                                    .font(.title3)
                                                    .fontWeight(.bold)
                                                //Text
                                                
                                                Spacer()
                                            }//HStack
                                        }//VStack
                                    }//HStack
                                    .zIndex(2)
                                    
                                    Rectangle()
                                        .fill(Color.primary)
                                        .offset(y: 16)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 2)
                                        .zIndex(1)
                                    //Rectangle
                                }//ZStack
                                .zIndex(Double(products.data.count - product.productId))
                            }//ForEach
                            .listRowSeparator(.hidden)
                        }//List
                        .listStyle(.plain)
                        .navigationTitle("")
                        .scrollIndicators(.hidden)
                    } else {
                        Spacer()
                        
                        Text("No \(self.reviewCases[self.selectedReviewIndex].value)-star products currently.")
                            .foregroundStyle(Color.primary)
                        //Text
                    }//if
                } else {
                    Spacer()
                    
                    Text("No products at the moment.")
                        .foregroundStyle(Color.primary)
                    //Text
                }//if
            }//if
            
            Spacer()
        }//NavigationStack
    }//body
    
    private func filterProductsPerRating(_ products: [Product]) -> [Product] {
        if self.reviewCases[self.selectedReviewIndex].stars != .all {
            return products.filter({ $0.productRating == self.reviewCases[self.selectedReviewIndex].value })
        }
        
        return products
    }//filterProductsPerRating
}//ReviewsView

#Preview {
    MainView()
}
