import SwiftUI

public struct ProductsListView: View {
    @State public var products: [Product] = []
    @State private var sortCases: [SortCase] = SortCases().cases
    @State private var selectedSortIndex: Int = 0
    
    public let collectionName: String
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach (self.products) { product in
                    ZStack {
                        NavigationLink {
                            ProductView(product: product)
                        } label: {
                            EmptyView()
                        }//NavigationLink
                        .opacity(0)
                        .zIndex(2)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            if let image = product.productImages.first {
                                if let url = URL(string: image) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ZStack {
                                            Image("logo.valuetainment.portrait.original")
                                                .resizable()
                                                .frame(width: 160, height: 160)
                                                .zIndex(2)
                                            //Image
                                            
                                            Rectangle()
                                                .fill(.white)
                                                .scaledToFit()
                                                .zIndex(1)
                                            //Rectangle
                                        }//ZStack
                                    }//AsyncImage
                                    .cornerRadius(12)
                                }//if
                            }//if
                            
                            Rectangle()
                                .fill(.white)
                                .frame(height: 2)
                            //Rectangle
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(product.productName)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                //Text
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        ForEach(1...product.productRating, id: \.self) { _ in
                                            Image(systemName: "star.fill")
                                                .font(.title2)
                                                .foregroundStyle(.yellow)
                                        }//ForEach
                                    }//HStack
                                    
                                    Text(String(format: "$%.2f USD", product.productPrice))
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    //Text
                                }//VStack
                            }//VStack
                            .foregroundStyle(.white)
                        }//VStack
                        .padding()
                        .background(Color.primary)
                        .cornerRadius(12)
                        .zIndex(1)
                    }//ZStack
                    .shadow(
                        color: .black.opacity(0.2),
                        radius: 8, x: 0, y: 4
                    )//shadow
                }//ForEach
                .listRowSeparator(.hidden)
            }//List
            .listStyle(.plain)
            .navigationTitle(self.collectionName)
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker(selection: self.$selectedSortIndex, label: EmptyView()) {
                        ForEach(0..<self.sortCases.count, id: \.self) { i in
                            Text(self.sortCases[i].label)
                                .tag(i)
                            //Text
                        }//ForEach
                    }//Picker
                    .pickerStyle(.menu)
                }//ToolbarItem
                .sharedBackgroundVisibility(.hidden)
            }//toolbar
        }//NavigationStack
        .onChange(of: self.selectedSortIndex) {
            self.sortProducts(by: self.sortCases[self.selectedSortIndex].sortBy)
        }//onChange
    }//body
    
    private func sortProducts(by sortCase: SortParams) {
        switch(sortCase) {
        case .nameLow:
            self.products.sort(by: { $0.productName < $1.productName })
        case .nameHigh:
            self.products.sort(by: { $0.productName > $1.productName })
        case .priceLow:
            self.products.sort(by: { $0.productPrice < $1.productPrice })
        default:
            self.products.sort(by: { $0.productPrice > $1.productPrice })
        }//switch
    }//sortProducts
}//ProductsListView
