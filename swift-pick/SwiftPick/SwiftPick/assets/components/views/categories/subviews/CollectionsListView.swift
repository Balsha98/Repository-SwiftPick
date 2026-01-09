import SwiftUI

public struct CollectionsListView: View {
    public let category: Category
    public let collections: [Collection]
    public let products: [Product]
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach (self.collections) { collection in
                    ZStack {
                        NavigationLink {
                            ProductsListView(
                                products: self.products.filter({
                                    $0.categoryId == self.category.categoryId &&
                                    $0.collectionId == collection.collectionId
                                }).sorted(by: { $0.productName < $1.productName }),
                                collectionName: collection.collectionName
                            )//ProductsListView
                        } label: {
                            EmptyView()
                        }//NavigationLink
                        .opacity(0)
                        .zIndex(2)
                        
                        VStack {
                            HStack {
                                Text(collection.collectionName)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .cornerRadius(4)
                                //Text
                                
                                Spacer()
                            }//HStack
                            
                            Spacer()
                            
                            HStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 96, height: 2)
                                //Circle
                                
                                Spacer()
                                
                                Image("logo.valuetainment.portrait.inverted")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                //Image
                            }//HStack
                        }//VStack
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.primary)
                        .cornerRadius(4)
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
            .navigationTitle(self.category.categoryName)
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.hidden)
        }//NavigationStack
    }//body
}//CollectionsListView
