import SwiftUI

public struct CheckoutPaymentOverviewView: View {
    public let email: String
    public let countryOrRegion: String
    public let address: String
    public let city: String
    public let zipCode: String
    public let state: String
    public let shippingMethod: String
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                VStack(alignment: .leading, spacing: 0){
                    HStack(spacing: 12) {
                        Text("Contact:")
                            .fontWeight(.semibold)
                        //Text
                        
                        Text("\(self.email)")
                            .multilineTextAlignment(.trailing)
                            .lineLimit(1)
                        //Text
                    }//HStack
                    .padding()
                    
                    Rectangle()
                        .fill(.white)
                        .frame(height: 4)
                    //Rectangle
                    
                    HStack(spacing: 12) {
                        Text("Address:")
                            .fontWeight(.semibold)
                        //Text
                        
                        Text("\(self.email)")
                            .multilineTextAlignment(.trailing)
                            .lineLimit(1)
                        //Text
                    }//HStack
                    .padding()
                    
                    Rectangle()
                        .fill(.white)
                        .frame(height: 4)
                    //Rectangle
                    
                    HStack(spacing: 12) {
                        Text("Shipping:")
                            .fontWeight(.semibold)
                        //Text
                        
                        Text("\(self.shippingMethod)")
                            .multilineTextAlignment(.trailing)
                            .lineLimit(1)
                        //Text
                    }//HStack
                    .padding()
                }//VStack
                .foregroundStyle(.white)
                .background(Color.primary)
                .cornerRadius(12)
            }//ZStack
            .shadow(
                color: .black.opacity(0.2),
                radius: 4, x: 0, y: 2
            )//shadow
            
            HStack(spacing: 4) {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(.yellow)
                //Image
                
                Text("Go back a step to edit this information.")
                    .font(.caption)
                //Text
                
                Spacer()
            }//HStack
        }//VStack
        .frame(maxWidth: .infinity)
    }//body
}//CheckoutPaymentOverviewView
