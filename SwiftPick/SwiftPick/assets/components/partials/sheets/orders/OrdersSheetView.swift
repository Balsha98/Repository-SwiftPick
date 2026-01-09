import SwiftUI

public struct OrdersSheetView: View {
    @Binding public var viewOrders: Bool
    @Binding public var selectedTab: TabViews
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Orders")
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
                
                Button {
                    self.selectedTab = .categories
                    self.viewOrders = false
                } label: {
                    VStack {
                        Image(systemName: "plus")
                            .frame(width: 32, height: 32)
                            .foregroundStyle(Color.primary)
                        //Image
                    }//VStack
                }//Button
            }//HStack
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            
            Spacer()
            
            Text("To be continuned...")
                .foregroundStyle(Color.primary)
            //Text
            
            Spacer()
        }//VStack
    }//body
}//OrdersSheetView
