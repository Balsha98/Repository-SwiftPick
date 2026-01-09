import SwiftUI
import FirebaseAuth

public struct CartItemView: View {
    @State private var selectedQuantity: Int = 1
    
    private let user: User = Auth.auth().currentUser!
    
    public var cartHandler: CartHandler
    public var cartItem: CartItem
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .top) {
                if let url = URL(string: self.cartItem.productImage) {
                    ZStack(alignment: .topLeading) {
                        Button {
                            self.cartHandler.deleteCartItem(self.cartItem.productId)
                            
                            withAnimation {
                                self.cartHandler.fetchCartItems()
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
                        .offset(x: 8, y: 8)
                        .shadow(
                            color: .black.opacity(0.2),
                            radius: 4, x: 0, y: 2
                        )//shadow
                        .zIndex(2)
                        
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
                        .zIndex(1)
                    }//ZStack
                }//if
                
                Spacer()
                
                VStack(spacing: 8) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(self.cartItem.productName)
                            .fontWeight(.bold)
                            .lineLimit(1)
                        //Text
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 8) {
                                ForEach(0..<self.cartItem.productRating, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .font(.title3)
                                        .foregroundStyle(.yellow)
                                    //Image
                                }//ForEach
                            }//HStack
                            
                            HStack {
                                Text(String(format: "$%.2f USD", self.cartItem.productPrice))
                                    .font(.title3)
                                    .fontWeight(.bold)
                                //Text
                                
                                Spacer()
                            }//HStack
                        }//VStack
                    }//VStack
                    
                    HStack {
                        HStack {
                            Button {
                                if self.selectedQuantity > 1 {
                                    self.selectedQuantity -= 1
    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        withAnimation {
                                            self.cartHandler.fetchCartItems()
                                        }//withAnimation
                                    }//asyncAfter
                                }//if
                            } label: {
                                ZStack {
                                    Image(systemName: "minus")
                                        .font(.caption)
                                        .foregroundStyle(Color.primary)
                                    //Image
                                    
                                    Circle()
                                        .stroke(Color.primary, lineWidth: 2)
                                        .frame(width: 24, height: 24)
                                    //Rectangle
                                }//ZStack
                            }//Button
                            
                            Text("\(self.selectedQuantity)")
                                .frame(width: 48)
                                .fontWeight(.semibold)
                            //Text
                            
                            Button {
                                self.selectedQuantity += 1
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    withAnimation {
                                        self.cartHandler.fetchCartItems()
                                    }//withAnimation
                                }//asyncAfter
                            } label: {
                                ZStack {
                                    Image(systemName: "plus")
                                        .font(.caption)
                                        .foregroundStyle(Color.primary)
                                    //Image
                                    
                                    Circle()
                                        .stroke(Color.primary, lineWidth: 2)
                                        .frame(width: 24, height: 24)
                                    //Rectangle
                                }//ZStack
                            }//Button
                        }//HStack
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                            if !self.cartItem.productColor.isEmpty {
                                let red = Double(self.cartItem.productColor.components(separatedBy: "|")[0])! / 255
                                let green = Double(self.cartItem.productColor.components(separatedBy: "|")[1])! / 255
                                let blue = Double(self.cartItem.productColor.components(separatedBy: "|")[2])! / 255
                        
                                Circle()
                                    .fill(Color(red: red, green: green, blue: blue))
                                    .stroke(.black, lineWidth: 1.2)
                                    .frame(width: 32)
                                    .zIndex(1)
                                //Circle
                            }//if
                        
                            if !self.cartItem.productSize.isEmpty {
                                ZStack {
                                    Text(self.cartItem.productSize)
                                        .font(.system(size: 12))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primary)
                                        .zIndex(2)
                        
                                    Circle()
                                        .fill(.white)
                                        .stroke(Color.primary, lineWidth: 1.2)
                                        .frame(width: 32)
                                        .zIndex(1)
                                    //Circle
                                }//ZStack
                            }//if
                        }//HStack
                        .padding(.trailing, 8)
                    }//HStack
                }//VStack
            }//HStack
            .padding(.bottom, 24)
            .zIndex(2)
            
            Rectangle()
                .fill(Color.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 2)
                .zIndex(1)
            //Rectangle
        }//ZStack
        .onChange(of: self.selectedQuantity) {
            self.cartItem.productQuantity = self.selectedQuantity
            
            self.cartHandler.addCartItem(self.cartItem)
        }//onChange
        .onAppear {
            self.selectedQuantity = self.cartItem.productQuantity
        }//onAppear
    }//body
}//CartItemView
