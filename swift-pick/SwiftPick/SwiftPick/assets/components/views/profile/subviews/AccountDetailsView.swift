import SwiftUI

public struct AccountDetailsView: View {
    @State private var viewAlert: Bool = false
    @State private var isSuccessful: Bool = true
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var age: String = ""
    @State private var countryOfOrigin: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    
    public let profileHandler: ProfileHandler
    public let userProfile: UserProfile
    
    public init(profileHandler: ProfileHandler, userProfile: UserProfile) {
        self._firstName = State(initialValue: userProfile.firstName!)
        self._lastName = State(initialValue: userProfile.lastName!)
        self._age = State(initialValue: String(userProfile.age!))
        self._countryOfOrigin = State(initialValue: userProfile.countryOfOrigin!)
        self._email = State(initialValue: userProfile.email)
        self._phoneNumber = State(initialValue: userProfile.phoneNumber!)
        
        self.profileHandler = profileHandler
        self.userProfile = userProfile
    }//init
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Account Details")
                    .font(.title2)
                    .fontWeight(.bold)
                //Text
                
                Spacer()
                
                Button {
                    self.profileHandler.updateUserProfileForFields(with: [
                        "firstName": self.firstName,
                        "lastName": self.lastName,
                        "age": Int(self.age)!,
                        "phoneNumber": self.phoneNumber,
                        "countryOfOrigin": self.countryOfOrigin
                    ], exists: true)//updateUserProfileForFields
                    
                    self.profileHandler.fetchUserProfile()

                    self.viewAlert = true
                } label: {
                    Image(systemName: "square.and.arrow.up.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color.primary)
                    //Image
                }//Button
            }//HStack
            
            ZStack {
                VStack(spacing: 0) {
                    ProfileTextFieldRowView(
                        text: self.$firstName,
                        icon: "person.fill",
                        prompt: "First Name",
                        keyboard: .default
                    )//ProfileTextFieldRowView
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    ProfileTextFieldRowView(
                        text: self.$lastName,
                        icon: "person.fill",
                        prompt: "Last Name",
                        keyboard: .default
                    )//ProfileTextFieldRowView
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    ProfileTextFieldRowView(
                        text: self.$age,
                        icon: "birthday.cake.fill",
                        prompt: "Age",
                        keyboard: .numberPad
                    )//ProfileTextFieldRowView
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    ProfileTextFieldRowView(
                        text: self.$email,
                        icon: "envelope.fill",
                        prompt: "Email Address",
                        keyboard: .emailAddress,
                        isDisabled: true
                    )//ProfileTextFieldRowView
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    ProfileTextFieldRowView(
                        text: self.$phoneNumber,
                        icon: "phone.fill",
                        prompt: "Phone",
                        keyboard: .phonePad
                    )//ProfileTextFieldRowView
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    ProfileTextFieldRowView(
                        text: self.$countryOfOrigin,
                        icon: "flag.fill",
                        prompt: "Country",
                        keyboard: .default
                    )//ProfileTextFieldRowView
                }//VStack
                .foregroundStyle(.black)
                .background(.white)
                .cornerRadius(4)
            }//ZStack
            .shadow(
                color: .black.opacity(0.2),
                radius: 4, x: 0, y: 4
            )//shadow
        }//VStack
        .sheet(isPresented: self.$viewAlert) {
            AlertSheetView(
                viewAlert: self.$viewAlert,
                icon: self.isSuccessful ? "check" : "exclamation",
                heading: "Account Update \(self.isSuccessful ? "Successful" : "Unsuccessful")",
                message: self.isSuccessful ? "Account details have been updated." : "The provided data is invalid."
            ) {
                self.viewAlert = false
            }//AlertSheetView
        }//sheet
    }//body
}//AccountDetailsView
