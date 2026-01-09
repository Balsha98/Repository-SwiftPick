import SwiftUI

public struct AdditionalDetailsView: View {
    @State private var viewAlert: Bool = false
    @State private var isSuccessful: Bool = true
    @State private var dateOfBirth: Date = Date()
    @State private var genderCases: [GenderCase] = GenderCases().cases
    @State private var selectedGenderIndex: Int = 0
    @State private var gender: String = ""
    @State private var pbdSubscriber: Bool = true
    
    public let profileHandler: ProfileHandler
    public let userProfile: UserProfile
    
    public init(profileHandler: ProfileHandler, userProfile: UserProfile) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateObject = dateFormatter.date(from: userProfile.dateOfBirth!)
        self._dateOfBirth = State(initialValue: dateObject!)
        
        self._gender = State(initialValue: userProfile.gender!)
        self._pbdSubscriber = State(initialValue: userProfile.pbdSubscriber!)
        
        self.profileHandler = profileHandler
        self.userProfile = userProfile
    }//init
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Additional Details")
                    .font(.title2)
                    .fontWeight(.bold)
                //Text
                
                Spacer()
                
                Button {
                    var detailsData = [
                        "gender": self.genderCases[self.selectedGenderIndex].label,
                        "pbdSubscriber": self.pbdSubscriber
                    ]//detailsData
                    
                    if self.dateOfBirth != Date() {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        let dateString = dateFormatter.string(from: self.dateOfBirth)
                        detailsData["dateOfBirth"] = dateString
                    }//if
                    
                    self.profileHandler.updateUserProfileForFields(with: detailsData, exists: true)
                    
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
                    ProfilePickerRowView(
                        selectedPickerIndex: self.$selectedGenderIndex,
                        icon: "person.2.fill",
                        prompt: "Gender",
                        pickerCases: self.genderCases
                    )//ProfilePickerRowView
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    ProfileDateRowView(
                        date: self.$dateOfBirth,
                        icon: "calendar",
                        prompt: "Date of Birth"
                    )//ProfileDateRowView
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    ProfileToggleRowView(
                        toggle: self.$pbdSubscriber,
                        icon: "checkmark.circle.fill",
                        prompt: "Subscriber?"
                    )//ProfileToggleRowView
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
                message: self.isSuccessful ? "Additional details have been updated." : "The provided data is invalid."
            ) {
                self.viewAlert = false
            }//AlertSheetView
        }//sheet
    }//body
}//AdditionalDetailsView
