import SwiftUI

public struct ProfileOverviewView: View {
    @Binding public var viewOrders: Bool
    
    public let userProfile: UserProfile
    public let orderHandler: OrderHandler
    
    private var userFullName: String {
        if let firstName = userProfile.firstName, !firstName.isEmpty {
            if let lastName = userProfile.lastName, !lastName.isEmpty {
                return "\(firstName) \(lastName)"
            }//if
            
            return "\(firstName) & Last"
        }//if
        
        return "First & Last"
    }//userFullName
    
    private var totalOrders: Int {
        return self.orderHandler.orderItems.count
    }//if
    
    private var rewardsPoints: Int {
        return self.orderHandler.orderItems.reduce(0) { start, item in
            return start + item.rewardsPoints
        }//return
    }//rewardsPoints
    
    public var body: some View {
        ZStack {
            ZStack(alignment: .bottomTrailing) {
                ZStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(Color.primary)
                        .clipShape(Circle())
                        .zIndex(2)
                    //Image
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 128)
                        .shadow(
                            color: .black.opacity(0.2),
                            radius: 4, x: 0, y: 4
                        )//shadow
                        .zIndex(1)
                    //Circle
                }//ZStack
                
                ZStack {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.title)
                        .foregroundStyle(.green)
                        .zIndex(2)
                    //Image
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 24)
                        .zIndex(1)
                    //Circle
                }//ZStack
            }//ZStack
            .offset(y: -96)
            .zIndex(2)
            
            ZStack(alignment: .topTrailing) {
                Button {
                    self.viewOrders = true
                } label: {
                    Image(systemName: "list.bullet.clipboard.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                    //Image
                }//Button
                .offset(x: -16, y: 16)
                .zIndex(2)
                
                VStack(spacing: 12) {
                    VStack(spacing: 2) {
                        Text(self.userFullName)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text(self.userProfile.email)
                    }//VStack
                    .foregroundStyle(.white)
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 4)
                        //Rectangle
                        
                        HStack {
                            VStack(spacing: 4) {
                                Text("Orders")
                                    .fontWeight(.semibold)
                                //Text
                                
                                Text("\(self.totalOrders)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                //Text
                            }//VStack
                            .frame(maxWidth: .infinity)
                            
                            Rectangle()
                                .fill(.white)
                                .frame(width: 2)
                                .cornerRadius(4)
                            //Rectangle
                            
                            VStack(spacing: 4) {
                                Text("Rewards")
                                    .fontWeight(.semibold)
                                //Text
                                
                                Text("\(self.rewardsPoints)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                //Text
                            }//VStack
                            .frame(maxWidth: .infinity)
                        }//HStack
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .foregroundStyle(.white)
                        .background(Color.primary)
                        .cornerRadius(4)
                    }//VStack
                }//VStack
                .padding(.top, 80)
                .background(Color.primary)
                .cornerRadius(16)
                .shadow(
                    color: .black.opacity(0.2),
                    radius: 4, x: 0, y: 4
                )//shadow
                .zIndex(1)
            }//ZStack
        }//ZStack
        .padding(.top, 40)
        .onAppear {
            self.orderHandler.fetchUserOrders()
        }//onAppear
    }//body
}//ProfileOverviewView
