import SwiftUI

public struct CheckoutSafeAreaCalcView: View {
    public let totalPrice: Double
    
    public var body: some View {
        VStack(spacing: 16) {
            Rectangle()
                .fill(Color.primary)
                .frame(height: 2)
                .cornerRadius(4)
            //Rectangle
            
            HStack {
                Text("Total:")
                
                Spacer()
                
                Text(String(format: "$%.2f", self.totalPrice))
            }//HStack
            .font(.title3)
            .fontWeight(.bold)            
        }//VStack
        .padding()
        .foregroundStyle(.black)
        .background(.white)
    }//body
}//
