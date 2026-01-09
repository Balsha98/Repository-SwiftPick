import SwiftUI

public struct ReviewDetailsView: View {
    public let reviewItem: ReviewItem
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                ZStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .foregroundStyle(Color.primary)
                        .clipShape(Circle())
                        .zIndex(2)
                    //Image
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 56)
                        .shadow(
                            color: .black.opacity(0.2),
                            radius: 4, x: 0, y: 2
                        )//shadow
                        .zIndex(1)
                    //Circle
                }//ZStack
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(self.reviewItem.fullName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    //Text
                    
                    HStack {
                        ForEach(1...self.reviewItem.rating, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            //Image
                        }//ForEach
                    }//HStack
                    
                    Text(self.reviewItem.review)
                }//VStack
            }//HStack
            
            Rectangle()
                .fill(Color.primary)
                .frame(height: 2)
            //Rectangle
        }//VStack
    }//body
}//ReviewDetailsView
