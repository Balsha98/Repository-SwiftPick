import SwiftUI

public struct ReviewsSortingView: View {
    @Binding public var reviewCases: [ReviewCase]
    @Binding public var selectedReviewIndex: Int
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(0..<self.reviewCases.count, id: \.self) { i in
                    Button {
                        self.selectedReviewIndex = i
                    } label: {
                        ZStack {
                            let isSelected = self.selectedReviewIndex == i
                            
                            Capsule()
                                .stroke(isSelected ? .white : Color.primary, lineWidth: 2)
                                .frame(width: 80, height: 32)
                                .zIndex(2)
                            //Capsule
                            
                            HStack(spacing: 4) {
                                if i != 0 {
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                    //Image
                                }//if
                                
                                Text(self.reviewCases[i].stars == .all ? "All" : "\(self.reviewCases[i].value)")
                                    .foregroundStyle(isSelected ? .white : .black)
                                //Text
                            }//HStack
                            .frame(width: 80, height: 32)
                            .background(isSelected ? Color.primary : .white)
                            .clipShape(Capsule())
                            .zIndex(1)
                        }//ZStack
                    }//Button
                }//ForEach
            }//HStack
        }//ScrollView
        .padding([.horizontal, .bottom])
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }//body
}//ReviewsSortingView
