import SwiftUI
import SwiftData

public struct FavoritesFullScreenView: View {
    @Environment(\.modelContext) private var model
    
    @Query(sort: \FavoriteItem.productId, order: .reverse) private var favoriteItems: [FavoriteItem]
    
    @State private var isEditable: Bool = false
    
    @Binding public var selectedTab: TabViews
    @Binding public var viewFavorites: Bool
    
    public let requestHandler: RequestHandler
    
    public var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Favorites")
                        .font(.title3)
                        .fontWeight(.semibold)
                    //Text
                    
                    UnevenRoundedRectangle(
                        topLeadingRadius: 4,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 4
                    )//UnevenRoundedRectangle
                        .fill(Color.primary)
                        .frame(width: 48, height: 2)
                }//VStack
                
                Spacer()
                
                HStack(spacing: 8) {
                    Button {
                        self.selectedTab = .categories
                        self.viewFavorites = false
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 32, height: 32)
                            .foregroundStyle(Color.primary)
                        //Image
                    }//Button
                    
                    if !self.favoriteItems.isEmpty {
                        Button {
                            self.isEditable.toggle()
                        } label: {
                            Image(systemName: self.isEditable ? "trash.slash.fill" : "trash.fill")
                                .frame(width: 32, height: 32)
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                                .background(Color.primary.opacity(self.isEditable ? 0.4 : 1))
                                .clipShape(Circle())
                            //Image
                        }//Button
                    }//if
                    
                    Button {
                        self.viewFavorites = false
                    } label: {
                        Image(systemName: "chevron.down")
                            .frame(width: 32, height: 32)
                            .foregroundStyle(Color.primary)
                        //Image
                    }//Button
                }//HStack
            }//HStack
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            
            Spacer()
            
            if !self.favoriteItems.isEmpty {
                let products = self.requestHandler.data["products"] as? Products

                List {
                    ForEach(self.favoriteItems, id: \.self) { favoriteItem in
                        ZStack(alignment: .bottom) {
                            NavigationLink {
                                if let products = products {
                                    ProductView(
                                        product: products.data.filter(
                                            { $0.productId == favoriteItem.productId }
                                        ).first!
                                    )//ProductView
                                }//if
                            } label: {
                                EmptyView()
                            }//NavigationLink
                            .disabled(self.isEditable)
                            .opacity(0)
                            .zIndex(2)
                            
                            HStack {
                                if let url = URL(string: favoriteItem.productImage) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                        //Image
                                    } placeholder: {
                                        Image("logo.valuetainment.portrait.original")
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                        //Image
                                    }//AsyncImage
                                    .cornerRadius(4)
                                }//if
                                
                                Spacer()
                                
                                ZStack(alignment: .bottomTrailing) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(favoriteItem.productName)
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                        //Text
                                        
                                        HStack(spacing: 8) {
                                            ForEach(0..<favoriteItem.productRating, id: \.self) { _ in
                                                Image(systemName: "star.fill")
                                                    .font(.title3)
                                                    .foregroundStyle(.yellow)
                                                //Image
                                            }//ForEach
                                        }//HStack
                                        
                                        HStack {
                                            Text(String(format: "$%.2f USD", favoriteItem.productPrice))
                                                .font(.title3)
                                                .fontWeight(.bold)
                                            //Text

                                            Spacer()
                                        }//HStack
                                    }//VStack
                                    
                                    if self.isEditable {
                                        Button {
                                            let itemToDelete = self.favoriteItems.filter(
                                                { $0.productId == favoriteItem.productId}
                                            ).first!
                                            
                                            self.model.delete(itemToDelete)
                                            
                                            withAnimation {
                                                try? self.model.save()
                                            }//withAnimation
                                        } label: {
                                            VStack {
                                                Image(systemName: "trash.fill")
                                                    .frame(width: 32, height: 32)
                                                    .font(.system(size: 14))
                                                    .foregroundStyle(.white)
                                                    .background(Color.primary)
                                                    .clipShape(Circle())
                                                //Image
                                            }//VStack
                                        }//Button
                                        .padding(.trailing, 8)
                                    }//if
                                }//ZStack
                            }//HStack
                            .zIndex(1)
                            
                            Rectangle()
                                .fill(Color.primary)
                                .offset(y: 16)
                                .frame(maxWidth: .infinity)
                                .frame(height: 2)
                                .zIndex(1)
                            //Rectangle
                        }//ZStack
                        .zIndex(Double(self.favoriteItems.count + favoriteItem.productId))
                    }//ForEach
                    .listRowSeparator(.hidden)
                }//List
                .listStyle(.plain)
                .navigationTitle("")
                .scrollIndicators(.hidden)
            } else {
                Text("No favorites at the moment.")
                    .foregroundStyle(Color.primary)
                //Text
            }//if
            
            Spacer()
        }//NavigationStack
    }//body
}//FavoritesFullScreenView
