import SwiftUI

public struct AppLoadingView: View {
    @State private var isBlinking: Bool = false
    
    public var body: some View {
        VStack(spacing: 4) {
            Spacer()
            
            Image("logo.swift.pick")
                .resizable()
                .frame(width: 120, height: 120)
                .opacity(self.isBlinking ? 0.2 : 1)
            //Image
            
            VStack(spacing: 2) {
                Text("Welcome to SwiftPick")
                    .font(.title)
                    .fontWeight(.bold)
                //Text
                
                VStack(spacing: 8) {
                    Text("Inspired by Valuetainment.")
                        .font(.callout)
                        .italic()
                    //Text
                    
                    Image("logo.valuetainment.portrait.original")
                        .resizable()
                        .frame(width: 48, height: 48)
                    //Image
                }//VStack
            }//VStack
            
            Spacer()
            
            Text("© 2025 SwiftPick")
                .font(.caption)
                .foregroundStyle(Color.primary)
            //Text
        }//VStack
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.4).repeatForever()) {
                self.isBlinking = true
            }//withAnimation
        }//onAppear
    }//body
}//AppLoadingView

#Preview {
    AppLoadingView()
}
