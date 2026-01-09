import SwiftUI

public struct AlertSheetView: View {
    @State private var isScaling: Bool = false
    
    @Binding public var viewAlert: Bool
    
    public let icon: String
    public let heading: String
    public let message: String
    public let action: () -> Void
    
    private var isSuccessful: Bool {
        return self.icon == "check"
    }//isSuccessful
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                self.viewAlert = false
            } label: {
                Image(systemName: "chevron.down")
                    .font(.callout)
                //Image
            }//Button
            .padding()
            .foregroundStyle(.white)
            .background(Color.primary)
            .clipShape(Circle())
            .cornerRadius(4)
            .offset(x: -16, y: 16)
            .shadow(
                color: .black.opacity(0.2),
                radius: 4, x: 0, y: 4
            )//shadow
            .zIndex(2)
            
            VStack(spacing: 8) {
                Image(systemName: "\(self.icon)mark.circle.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(self.isSuccessful ? .green : Color.primary)
                    .scaleEffect(self.isScaling ? 1.1 : 1)
                //Image
                
                VStack(spacing: 2) {
                    Text(self.heading)
                        .font(.title2)
                        .fontWeight(.bold)
                    //Text
                    
                    Text(self.message)
                }//VStack
                
                Button {
                    self.action()
                } label: {
                    Text(self.isSuccessful ? "Confirm" : "Try Again")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 32)
                        .foregroundStyle(.white)
                        .background(self.isSuccessful ? .green : Color.primary)
                        .clipShape(Capsule())
                    //Text
                }//Button
                .padding(.top, 16)
            }//VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .zIndex(1)
        }//ZStack
        .onAppear {
            withAnimation(.easeInOut(duration: 0.4).repeatForever()) {
                self.isScaling = true
            }//withAnimation
        }//onAppear
    }//body
}//AlertSheetView
