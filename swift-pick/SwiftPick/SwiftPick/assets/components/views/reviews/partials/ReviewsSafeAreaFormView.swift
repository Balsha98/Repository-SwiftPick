import SwiftUI

public struct ReviewsSafeAreaFormView: View {
    @State private var viewAlert: Bool = false
    @State private var isSuccessful: Bool = false
    @State private var fullName: String = ""
    @State private var rating: Int = 1
    @State private var review: String = ""
    
    @Binding public var viewSafeArea: Bool
    
    public let reviewHandler: ReviewHandler
    
    public let productId: Int
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                withAnimation {
                    self.viewSafeArea = false
                }//withAnimation
            } label: {
                Image(systemName: "x.circle.fill")
                    .frame(width: 24, height: 24)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .background(Color.primary)
                    .clipShape(Circle())
                //Image
            }//Button
            .offset(x: -24, y: -12)
            .zIndex(3)
            
            Rectangle()
                .fill(.black)
                .frame(height: 2)
                .zIndex(2)
            //Rectangle
            
            VStack {
                VStack(spacing: 12) {
                    ReviewsTextFieldRowView(
                        text: self.$fullName,
                        prompt: "Full Name",
                        keyboard: .default
                    )//ReviewsTextFieldRowView
                    
                    HStack {
                        ForEach(1...5, id: \.self) { i in
                            Button {
                                self.rating = i
                            } label: {
                                Image(systemName: "star.fill")
                                    .font(.title2)
                                    .foregroundStyle(.yellow)
                                    .opacity(self.rating >= i ? 1 : 0.4)
                                //Image
                            }//Button
                        }//ForEach
                    }//HStack
                    
                    ReviewsTextFieldRowView(
                        text: self.$review,
                        prompt: "Review",
                        keyboard: .default
                    )//ReviewsTextFieldRowView
                }//VStack
                
                Spacer()
                
                Button {
                    // Guard clause: simple form validation.
                    if self.fullName.isEmpty || self.review.isEmpty {
                        return self.viewAlert = true
                    }//if
                    
                    self.isSuccessful = true
                    
                    self.reviewHandler.addNewReviewItem(ReviewItem(
                        productId: self.productId,
                        fullName: self.fullName,
                        rating: self.rating,
                        review: self.review
                    ))//addNewReviewItem
                } label: {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.primary)
                        .cornerRadius(4)
                    //Text
                }//Button
            }//VStack
            .frame(maxWidth: .infinity)
            .frame(height: 240)
            .padding(.vertical, 32)
            .padding(.horizontal, 24)
            .background(.white)
            .zIndex(1)
        }//ZStack
        .sheet(isPresented: self.$viewAlert) {
            AlertSheetView(
                viewAlert: self.$viewAlert,
                icon: self.isSuccessful ? "check" : "exclamation",
                heading: self.isSuccessful ? "Successful Review Posting" : "Action Failed",
                message: self.isSuccessful ? "Your review was successfully added" : "Make sure to provide valid data."
            ) {
                self.viewAlert = false
            }//AlertSheetView
        }//sheet
        .onChange(of: self.isSuccessful) {
            if self.isSuccessful {
                self.reviewHandler.fetchProductReviews(self.productId)
            }//if
            
            self.viewAlert = true
        }//onChange
    }//body
}//ReviewsSafeAreaFormView
