import SwiftUI

public struct CategoriesScrollView: View {
    @Binding public var selectedTab: TabViews
    
    public var categories: Categories?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Categories")
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
                    if let categories = categories {
                        ForEach (categories.data) { category in
                            VStack {
                                HStack {
                                    Text(category.categoryName)
                                        .font(.title3)
                                        .fontWeight(.semibold)
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
}//CategoriesScrollView
