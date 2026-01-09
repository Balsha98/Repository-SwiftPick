import SwiftUI
import FirebaseAuth

public struct MainView: View {
    @State private var user: User? = nil
    
    public var body: some View {
        ZStack {
            if self.user == nil {
                AuthView(user: self.$user)
            } else {
                MainTabView(user: self.$user)
            }//if
        }//ZStack
        .onAppear {
            // Check whether a user is logged in.
            if let user = Auth.auth().currentUser {
                self.user = user
            }//if
        }//onAppear
    }//body
}//MainView

#Preview {
    MainView()
}
