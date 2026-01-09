import SwiftUI

public struct CheckoutShippingMethodsView: View {
    @Binding public var selectedMethod: ShippingMethods
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Shipping Method")
                    .font(.title2)
                    .fontWeight(.semibold)
                //Text
                
                Spacer()
            }//HStack
            
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    Button {
                        self.selectedMethod = .free
                    } label: {
                        HStack {
                            Image(systemName: self.selectedMethod == .free ? "circle.circle.fill" : "circle")
                                .font(.system(size: 24))
                                .foregroundStyle(Color.primary)
                            //Image
                            
                            Text("Free Shipping")
                                .font(.system(size: 14))
                            //Text
                        }//HStack
                        
                        Spacer()
                        
                        Text("FREE")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        //Text
                    }//Button
                    .padding(12)
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    Button {
                        self.selectedMethod = .insuredStandard
                    } label: {
                        HStack {
                            Image(systemName: self.selectedMethod == .insuredStandard ? "circle.circle.fill" : "circle")
                                .font(.system(size: 24))
                                .foregroundStyle(Color.primary)
                            //Image
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Insured Standard Shipping")
                                    .font(.system(size: 14))
                                //Text
                                
                                Text("Avg. 3-5 Business Days")
                                    .font(.caption)
                                    .foregroundStyle(.black.opacity(0.6))
                                //Text
                            }//VStack
                        }//HStack
                        
                        Spacer()
                        
                        Text("$12.00")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        //Text
                    }//Button
                    .padding(12)
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    Button {
                        self.selectedMethod = .insuredTwoDay
                    } label: {
                        HStack {
                            Image(systemName: self.selectedMethod == .insuredTwoDay ? "circle.circle.fill" : "circle")
                                .font(.system(size: 24))
                                .foregroundStyle(Color.primary)
                            //Image
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Insured Two-Day Shipping")
                                    .font(.system(size: 14))
                                //Text
                                
                                Text("Avg. 2 Transit Day")
                                    .font(.caption)
                                    .foregroundStyle(.black.opacity(0.6))
                                //Text
                            }//VStack
                        }//HStack
                        
                        Spacer()
                        
                        Text("$18.00")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        //Text
                    }//Button
                    .padding(12)
                }//VStack
                .foregroundStyle(.black)
                .background(.white)
                .cornerRadius(4)
            }//ZStack
            .shadow(
                color: .black.opacity(0.2),
                radius: 4, x: 0, y: 4
            )//shadow
        }//VStack
    }//body
}//CheckoutShippingMethodsView
