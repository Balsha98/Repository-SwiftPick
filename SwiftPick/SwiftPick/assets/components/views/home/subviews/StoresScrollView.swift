import SwiftUI

public struct StoresScrollView: View {
    @Binding public var viewStores: Bool
    
    public var stores: Stores?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Stores")
                    .font(.title)
                    .fontWeight(.bold)
                //Text
                
                Spacer()
                
                Button {
                    self.viewStores = true
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundStyle(.black)
                    //Image
                }//Button
            }//HStack
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    if let stores = self.stores {
                        ForEach (stores.data) { store in
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(store.storeCity)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        //Text
                                        
                                        Text(store.storeState)
                                            .italic()
                                        //Text
                                    }//VStack
                                    
                                    Spacer()
                                }//HStack
                                
                                Spacer()
                                
                                HStack(alignment: .bottom) {
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 64, height: 2)
                                    //Rectangle
                                    
                                    Spacer()
                                    
                                    if let url = URL(string: store.storeStateLogo) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 64)
                                            //Image
                                        } placeholder: {
                                            Image("logo.valuetainment.portrait.inverted")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 48)
                                            //Image
                                        }//AsyncImage
                                        .zIndex(1)
                                    }//if
                                }//HStack
                            }//VStack
                            .frame(width: 240, height: 120)
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.primary)
                            .cornerRadius(4)
                        }//ForEach
                        .shadow(
                            color: .black.opacity(0.2),
                            radius: 4, x: 0, y: 4
                        )//shadow
                    }//if
                }//HStack
            }//ScrollView
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }//VStack
    }//body
}//StoresScrollView
