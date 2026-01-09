import SwiftUI

public struct WelcomeView: View {
    public var body: some View {
        ZStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading) {
                        Text("Welcome")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        //Text
                        
                        Text("Experience the thrill.")
                            .italic()
                            .foregroundStyle(.white)
                        //Text
                    }//VStack
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(.white)
                        .frame(width: 64, height: 2)
                    //Rectangle
                }//VStack
                .padding(.bottom)
                
                Spacer()
                
                Image("pbd.individual.pointing")
                    .resizable()
                    .scaledToFit()
                //Image
            }//ZStack
            .frame(maxWidth: .infinity)
            .frame(height: 160)
            .padding(.top)
            .padding(.horizontal)
            .background(Color.primary)
            .cornerRadius(4)
        }//ZStack
        .shadow(
            color: .black.opacity(0.2),
            radius: 4, x: 0, y: 4
        )//shadow
    }//body
}//WelcomeView
