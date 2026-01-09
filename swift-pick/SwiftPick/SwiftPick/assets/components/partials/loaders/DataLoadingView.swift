import SwiftUI

public struct DataLoadingView: View {
    @State private var degrees: Double = 0
    
    public var body: some View {
        VStack(spacing: 4) {
            Spacer()
            
            Image("logo.swift.pick")
                .resizable()
                .frame(width: 96, height: 96)
                .rotationEffect(.degrees(self.degrees))
            //Image
            
            Spacer()
        }//VStack
        .frame(maxWidth: .infinity)
        .background(.white)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).repeatForever()) {
                self.degrees += 360
            }//withAnimation
        }//onAppear
    }//body
}//DataLoadingView

#Preview {
    DataLoadingView()
}
