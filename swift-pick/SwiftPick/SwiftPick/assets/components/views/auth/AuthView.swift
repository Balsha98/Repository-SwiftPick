import SwiftUI
import FirebaseAuth

public struct AuthView: View {
    @State private var viewAuth: AuthTypes = .login
    
    @Binding public var user: User?
    
    public var body: some View {
        if self.viewAuth == .login {
            LoginView(
                viewAuth: self.$viewAuth,
                user: self.$user
            )//LoginView
        } else if self.viewAuth == .signup {
            SignupView(
                viewAuth: self.$viewAuth,
                user: self.$user
            )//SignupView
        }//if
    }//body
}//AuthView

#Preview {
    MainView()
}
