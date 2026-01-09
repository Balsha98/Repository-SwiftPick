import SwiftUI
import FirebaseAuth

public struct LoginView: View {
    @State private var isLoading: Bool = true
    @State private var viewAlert: Bool = false
    @State private var isSuccessful: Bool = false
    @State private var initialUser: User? = nil
    @State private var email: String = ""
    @State private var password: String = ""
    
    @FocusState private var isFocused: FieldTypes?
    
    @Binding public var viewAuth: AuthTypes
    @Binding public var user: User?
    
    public var body: some View {
        ZStack {
            if self.isLoading {
                AppLoadingView()
            } else {
                VStack(spacing: 24) {
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Image("logo.swift.pick")
                            .resizable()
                            .frame(width: 120, height: 120)
                        //Image
                        
                        VStack(spacing: 2) {
                            Text("Welcome to SwiftPick")
                                .font(.title)
                                .fontWeight(.bold)
                            //Text
                            
                            Text("Please provide your credentials.")
                        }//VStack
                    }//VStack
                    
                    VStack(spacing: 12) {
                        AuthTextFieldView(
                            text: self.$email,
                            prompt: "Email Address",
                            width: 320,
                            contentType: .emailAddress,
                            keyboard: .emailAddress,
                            icon: "envelope.fill"
                        )//AuthTextFieldView
                        .focused(self.$isFocused, equals: .email)
                        .onSubmit {
                            self.isFocused = .password
                        }//onSubmit
                        
                        AuthSecureFieldView(
                            text: self.$password,
                            prompt: "Password",
                            width: 320,
                            contentType: .oneTimeCode,
                            keyboard: .default,
                            icon: "lock.fill"
                        )//AuthSecureFieldView
                        .focused(self.$isFocused, equals: .password)
                        .onSubmit {
                            self.login()
                        }//onSubmit
                    }//VStack
                    .padding(.horizontal)
                    
                    Button {
                        self.login()
                    } label: {
                        HStack(spacing: 4) {
                            Text("Login")
                            
                            Image(systemName: "arrow.right")
                                .font(.caption)
                        }//HStack
                        .padding(.vertical, 8)
                        .padding(.horizontal, 48)
                        .foregroundStyle(.white)
                        .background(Color.primary)
                        .clipShape(Capsule())
                    }//Button
                    
                    Spacer()
                    
                    HStack {
                        Text("Don't have an account?")
                        
                        Button {
                            withAnimation {
                                self.viewAuth = .signup
                            }//withAnimation
                        } label: {
                            Text("Sign Up!")
                                .font(.callout)
                                .foregroundStyle(Color.primary)
                            //Text
                        }//Button
                    }//HStack
                }//VStack
                .padding()
            }//if
        }//ZStack
        .sheet(isPresented: self.$viewAlert) {
            AlertSheetView(
                viewAlert: self.$viewAlert,
                icon: self.isSuccessful ? "check" : "exclamation",
                heading: "Login \(self.isSuccessful ? "Successful" : "Unsuccessful")",
                message: self.isSuccessful ? "You have successfully logged in." : "Invalid credentials provided."
            ) {
                self.viewAlert = false
                
                // DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                //     self.user = self.initialUser
                // }//asyncAfter
            }//AlertSheetView
        }//sheet
        // .onChange(of: self.isSuccessful) {
        //     self.viewAlert = true
        // }//onChange
        .onAppear {
            self.isFocused = .email
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isLoading = false
                }//withAnimation
            }//asyncAfter
        }//onAppear
    }//body
    
    private func login() {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { result, error in
            guard error == nil else {
                self.viewAlert = true
                
                print("Error Caught - Error while logging in an existing user.")
                print("Error Details - \(error!.localizedDescription)")
                
                return
            }//guard
            
            if let result = result {
                // self.initialUser = result.user
                
                // DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                //     self.user = result.user
                // }//asyncAfter
                
                self.user = result.user
            }//if
            
            // self.isSuccessful = true
        }//Auth
    }//login
}//LoginView

#Preview {
    MainView()
}
