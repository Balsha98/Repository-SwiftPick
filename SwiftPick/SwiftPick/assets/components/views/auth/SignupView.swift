import SwiftUI
import FirebaseAuth

public struct SignupView: View {
    @State private var isLoading: Bool = true
    @State private var viewAlert: Bool = false
    @State private var isSuccessful: Bool = false
    @State private var initialUser: User? = nil
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @FocusState private var focusedField: FieldTypes?
    
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
                        .focused(self.$focusedField, equals: .email)
                        .onSubmit {
                            self.focusedField = .password
                        }//onSubmit
                        
                        AuthSecureFieldView(
                            text: self.$password,
                            prompt: "Password",
                            width: 320,
                            contentType: .oneTimeCode,
                            keyboard: .default,
                            icon: "lock.fill"
                        )//AuthSecureFieldView
                        .focused(self.$focusedField, equals: .password)
                        .onSubmit {
                            self.focusedField = .confirm
                        }//onSubmit
                        
                        AuthSecureFieldView(
                            text: self.$confirmPassword,
                            prompt: "Confirm Password",
                            width: 320,
                            contentType: .oneTimeCode,
                            keyboard: .default,
                            icon: "lock.fill"
                        )//AuthSecureFieldView
                        .focused(self.$focusedField, equals: .confirm)
                        .onSubmit {
                            self.signup()
                        }//onSubmit
                    }//VStack
                    .padding(.horizontal)
                    
                    Button {
                        self.signup()
                    } label: {
                        HStack(spacing: 4) {
                            Text("Signup")
                            
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
                        Text("Already have an account?")
                        
                        Button {
                            withAnimation {
                                self.viewAuth = .login
                            }//withAnimation
                        } label: {
                            Text("Log In!")
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
                heading: "Signup \(self.isSuccessful ? "Successful" : "Unsuccessful")",
                message: self.isSuccessful ? "You have successfully signed up." : "Invalid credentials provided."
            ) {
                self.viewAlert = false
                
                // if let initialUser = self.initialUser {
                //     DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                //         self.user = initialUser
                //     }//asyncAfter
                // }//if
            }//AlertView
        }//sheet
        // .onChange(of: self.isSuccessful) {
        //     self.viewAlert = self.isSuccessful
        // }//onChange
        .onAppear {
            self.focusedField = .email
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isLoading = false
                }//withAnimation
            }//asyncAfter
        }//onAppear
    }//body
    
    private func signup() {
        if self.password == self.confirmPassword {
            Auth.auth().createUser(withEmail: self.email, password: self.password) { result, error in
                guard error == nil else {
                    self.viewAlert = true
                    
                    print("Error Caught - Error while creating a new user.")
                    print("Error Details - \(error!.localizedDescription)")
                    
                    return
                }//guard
                
                ProfileHandler().updateUserProfileForFields(with: ["email": self.email], exists: false)
                
                if let result = result {
                    // self.initialUser = result.user
                    
                    // DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    //     self.user = result.user
                    // }//asyncAfter
                    
                    self.user = result.user
                }//if
                
                // self.isSuccessful = true
            }//Auth
        } else {
            self.viewAlert = true
        }//if
    }//signup
}//SignupView

#Preview {
    MainView()
}
