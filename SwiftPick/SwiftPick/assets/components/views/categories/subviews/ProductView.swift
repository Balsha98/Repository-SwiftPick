import SwiftUI
import SwiftData

public struct ProductView: View {
    @Environment(\.modelContext) private var model
    
    @Query private var favoriteItems: [FavoriteItem]
    
    @State private var viewAlert: Bool = false
    @State private var isSuccessful: Bool = false
    @State private var isFavorited: Bool = false
    @State private var selectedColor: String = ""
    @State private var selectedSize: String = ""
    @State private var selectedQuantity: Int = 1
    
    public let cartHandler: CartHandler = CartHandler()

    public let product: Product
    
    private var isOnTheFavoritesList: Bool {
        return self.favoriteItems.contains(
            where: { $0.productId == self.product.productId }
        )//return
    }//isOnTheFavoritesList
    
    public var body: some View {
        ScrollView {
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
                                Text("Choose Color:")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                //Text
                                
                                ScrollView(.horizontal) {
                                    HStack(spacing: 8) {
                                        ForEach(self.product.productColors, id: \.self) { color in
                                            Button {
                                                self.selectedColor = color
                                            } label: {
                                                let isSelected = self.selectedColor == color
                                                
                                                let red = Double(color.components(separatedBy: "|")[0])! / 255
                                                let green = Double(color.components(separatedBy: "|")[1])! / 255
                                                let blue = Double(color.components(separatedBy: "|")[2])! / 255
                                                
                                                Circle()
                                                    .fill(Color(red: red, green: green, blue: blue))
                                                    .stroke(.black, lineWidth: 2)
                                                    .frame(width: 56)
                                                    .opacity(isSelected ? 0.4 : 1)
                                                    .zIndex(1)
                                                //Circle
                                            }//Button
                                        }//ForEach
                                    }//HStack
                                    .padding(2)
                                }//ScrollView
                            }//VStack
                        }//if
                        
                        if !self.product.productSizes.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Choose Size:")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                //Text
                                
                                ScrollView(.horizontal) {
                                    HStack(spacing: 8) {
                                        ForEach(self.product.productSizes, id: \.self) { size in
                                            Button {
                                                self.selectedSize = size
                                            } label: {
                                                ZStack {
                                                    let isSelected = self.selectedSize == size
                                                    
                                                    Text(size)
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(isSelected ? .white : Color.primary)
                                                        .zIndex(2)
                                                    //Text
                                                    
                                                    Circle()
                                                        .fill(isSelected ? Color.primary : .white)
                                                        .stroke(Color.primary, lineWidth: 2)
                                                        .frame(width: 56)
                                                        .zIndex(1)
                                                    //Circle
                                                }//ZStack
                                            }//Button
                                        }//ForEach
                                    }//HStack
                                    .padding(2)
                                }//ScrollView
                            }//VStack
                        }//if
                    }//VStack
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            Button {
                                if self.selectedQuantity > 1 {
                                    self.selectedQuantity -= 1
                                }//if
                            } label: {
                                ZStack {
                                    Image(systemName: "minus")
                                        .foregroundStyle(.white)
                                        .zIndex(2)
                                    //Image
                                    
                                    Circle()
                                        .fill(Color.primary)
                                        .stroke(Color.primary, lineWidth: 2)
                                        .frame(width: 48, height: 48)
                                        .zIndex(1)
                                    //Rectangle
                                }//ZStack
                            }//Button
                            
                            ZStack {
                                Text("\(self.selectedQuantity)")
                                    .frame(maxWidth: .infinity)
                                    .fontWeight(.semibold)
                                //Text
                                
                                Rectangle()
                                    .stroke(Color.primary, lineWidth: 4)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                                    .cornerRadius(4)
                                //Rectangle
                            }//ZStack
                            
                            Button {
                                self.selectedQuantity += 1
                            } label: {
                                ZStack {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .zIndex(2)
                                    //Image
                                    
                                    Circle()
                                        .fill(Color.primary)
                                        .stroke(Color.primary, lineWidth: 2)
                                        .frame(width: 48, height: 48)
                                        .zIndex(1)
                                    //Rectangle
                                }//ZStack
                            }//Button
                        }//HStack
                        
                        Button {
                            if !self.selectedColor.isEmpty || self.product.productColors.isEmpty {
                                if !self.selectedSize.isEmpty || self.product.productSizes.isEmpty {
                                    self.isSuccessful = true
                                    
                                    self.cartHandler.addCartItem(
                                        CartItem(
                                            productId: self.product.productId,
                                            productName: self.product.productName,
                                            productImage: self.product.productImages.first!,
                                            productSize: self.selectedSize,
                                            productColor: self.selectedColor,
                                            productRewardPoints: self.product.productRewardPoints,
                                            productRating: self.product.productRating,
                                            productQuantity: self.selectedQuantity,
                                            productPrice: self.product.productPrice
                                        )//CartItem
                                    )//addCartItem
                                    
                                    self.selectedColor = ""
                                    self.selectedSize = ""
                                }//if
                            }//if

                            self.viewAlert = true
                        } label: {
                            Text("Add to Cart")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundStyle(.white)
                                .background(Color.primary)
                                .cornerRadius(4)
                            //Text
                        }//Button
                    }//VStack
                    .padding(.top, 8)
                }//VStack
                
                Spacer()
            }//VStack
            .padding()
        }//ScrollView
        .scrollIndicators(.hidden)
        .sheet(isPresented: self.$viewAlert) {
            AlertSheetView(
                viewAlert: self.$viewAlert,
                icon: self.isSuccessful ? "check" : "exclamation",
                heading: self.isSuccessful ? "Added to Cart" : "Action Failed",
                message: self.isSuccessful ? "Product added to cart." : "Size/Color have to be selected!"
            ) {
                self.viewAlert = false
            }//AlertSheetView
        }//sheet
        .onAppear {
            if self.isOnTheFavoritesList {
                self.isFavorited = self.isOnTheFavoritesList
            }//if
        }//onAppear
    }//body
}//ProductView
