import SwiftUI

public struct TrendingScrollView: View {
    @Binding public var selectedTab: TabViews
    
    public var trendingCategories: [String] = ["Men", "Women"]
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Trending")
                    .font(.title)
                    .fontWeight(.bold)
                //Text
                
                Spacer()
                
                Button {
                    self.selectedTab = .categories
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundStyle(.black)
                    //Image
                }//Button
            }//HStack
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(self.trendingCategories, id: \.self) { trending in
                        ZStack {
                            VStack {
                                HStack {
                                    Spacer()
                                    
                                    Image("logo.valuetainment.portrait.inverted")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 48, height: 48)
                                    //Image
                                }//HStack
                                
                                Spacer()
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("\(trending)'s Wear")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                        //Text
                                        
                                        Button {
                                            self.selectedTab = .categories
                                        } label: {
                                            Text("Explore")
                                                .foregroundStyle(.white)
                                            //Text
                                        }//Button
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 24)
                                        .background(Color.primary)
                                        .clipShape(Capsule())
                                    }//VStack
                                    
                                    Spacer()
                                }//HStack
                            }//VStack
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                            .background(.white.opacity(0.2))
                            .cornerRadius(4)
                            .zIndex(2)
                            
                            Image("vt.\(trending.lowercased())s.wear")
                                .resizable()
                                .scaledToFit()
                                .containerRelativeFrame(.horizontal)
                                .zIndex(1)
                            //Image
                        }//ZStack
                        .cornerRadius(4)
                    }//ForEach
                }//HStack
                .shadow(
                    color: .black.opacity(0.2),
                    radius: 4, x: 0, y: 4
                )//shadow
            }//ScrollView
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }//VStack
    }//body
}//TrendingScrollView
