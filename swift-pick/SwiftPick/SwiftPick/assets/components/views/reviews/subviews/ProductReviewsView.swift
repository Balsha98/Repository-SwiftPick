import SwiftUI
import SwiftData

public struct ProductReviewsView: View {
    @Environment(\.modelContext) private var model
    
    @Query private var favoriteItems: [FavoriteItem]
    
    @State private var isFavorited: Bool = false
    @State private var viewSafeArea: Bool = false

    public let reviewHandler: ReviewHandler
    
    public let product: Product
    
    private var isOnTheFavoritesList: Bool {
        return self.favoriteItems.contains(
            where: { $0.productId == self.product.productId }
        )//return
    }//isOnTheFavoritesList
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 16) {
                    if let firstImage = self.product.productImages.first {
                        ZStack(alignment: .bottomTrailing) {
                            Button {
                                let favoriteItem = FavoriteItem(
                                    productId: product.productId,
                                    productName: product.productName,
                                    productImage: firstImage,
                                    productRating: product.productRating,
                                    productPrice: product.productPrice
                                )//FavoriteItem
                                
                                if !self.isOnTheFavoritesList {
                                    self.model.insert(favoriteItem)
                                } else {
                                    self.model.delete(favoriteItem)
                                }//if
                                
                                self.isFavorited.toggle()
                                
                                try? self.model.save()
                            } label: {
                                Image(systemName: self.isFavorited ? "heart.slash.fill" : "heart.fill")
                                    .frame(width: 32, height: 32)
                                    .padding(12)
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .background(Color.primary)
                                    .clipShape(Circle())
                                //Image
                            }//Button
                            .offset(x: -12, y: -12)
                            .zIndex(2)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(self.product.productImages, id: \.self) { image in
                                        if let url = URL(string: image) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .containerRelativeFrame(.horizontal)
                                                //Image
                                            } placeholder: {
                                                ZStack {
                                                    Image("logo.valuetainment.portrait.original")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .containerRelativeFrame(.horizontal)
                                                        .zIndex(2)
                                                    //Image
                                                    
                                                    Rectangle()
                                                        .fill(.white)
                                                        .scaledToFit()
                                                        .containerRelativeFrame(.horizontal)
                                                        .zIndex(1)
                                                    //Rectangle
                                                }//ZStack
                                            }//AsyncImage
                                            .cornerRadius(12)
                                        }//if
                                    }//ForEach
                                }//HStack
                            }//ScrollView
                            .zIndex(1)
                        }//ZStack
                        .padding()
                        .background(Color.primary)
                        .shadow(
                            color: .black.opacity(0.2),
                            radius: 8, x: 0, y: 4
                        )//shadow
                        .cornerRadius(12)
                    }//if
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text(self.product.productName)
                            .font(.title)
                            .fontWeight(.semibold)
                        //Text
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                ForEach(0..<self.product.productRating, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .font(.title2)
                                        .foregroundStyle(.yellow)
                                    //Image
                                }//ForEach
                            }//HStack
                            
                            Text(String(format: "$%.2f USD", self.product.productPrice))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            //Text
                        }//VStack
                        
                        VStack(alignment: .leading, spacing: 24) {
                            if !self.product.productColors.isEmpty {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Available Colors:")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    //Text
                                    
                                    ScrollView(.horizontal) {
                                        HStack(spacing: 8) {
                                            ForEach(self.product.productColors, id: \.self) { color in
                                                let red = Double(color.components(separatedBy: "|")[0])! / 255
                                                let green = Double(color.components(separatedBy: "|")[1])! / 255
                                                let blue = Double(color.components(separatedBy: "|")[2])! / 255
                                                
                                                Circle()
                                                    .fill(Color(red: red, green: green, blue: blue))
                                                    .stroke(.black, lineWidth: 2)
                                                    .frame(width: 56)
                                                //Circle
                                            }//ForEach
                                        }//HStack
                                        .padding(2)
                                    }//ScrollView
                                }//VStack
                            }//if
                            
                            if !self.product.productSizes.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Available Sizes:")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    //Text
                                    
                                    ScrollView(.horizontal) {
                                        HStack(spacing: 8) {
                                            ForEach(self.product.productSizes, id: \.self) { size in
                                                ZStack {
                                                    Text(size)
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(Color.primary)
                                                        .zIndex(2)
                                                    
                                                    Circle()
                                                        .fill(.white)
                                                        .stroke(Color.primary, lineWidth: 2)
                                                        .frame(width: 56)
                                                        .zIndex(1)
                                                    //Circle
                                                }//ZStack
                                            }//ForEach
                                        }//HStack
                                        .padding(2)
                                    }//ScrollView
                                }//VStack
                            }//if
                        }//VStack
                    }//VStack
                }
                
                VStack(spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Reviews")
                                .font(.title)
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
                        
                        Button {
                            withAnimation {
                                self.viewSafeArea = true
                            }//withAnimation
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color.primary)
                            //Image
                        }//Button
                    }//HStack
                    
                    if !self.reviewHandler.reviewItems.isEmpty {
                        ForEach(self.reviewHandler.reviewItems) { reviewItem in
                            ReviewDetailsView(reviewItem: reviewItem)
                        }//ForEach
                    } else {
                        Text("No reviews available at the moment.")
                            .padding(.top, 32)
                            .foregroundStyle(Color.primary)
                        //Text
                    }//if
                }//VStack
                
                Spacer()
            }//VStack
            .padding()
        }//ScrollView
        .navigationTitle("Product Reviews")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .safeAreaInset(edge: .bottom) {
            if self.viewSafeArea {
                ReviewsSafeAreaFormView(
                    viewSafeArea: self.$viewSafeArea,
                    reviewHandler: self.reviewHandler,
                    productId: self.product.productId
                )//ReviewsSafeAreaFormView
            }//if
        }//safeAreaInset
        .onAppear {
            self.reviewHandler.fetchProductReviews(self.product.productId)
            
            if self.isOnTheFavoritesList {
                self.isFavorited = self.isOnTheFavoritesList
            }//if
        }//onAppear
    }//body
}//ProductReviewsView
