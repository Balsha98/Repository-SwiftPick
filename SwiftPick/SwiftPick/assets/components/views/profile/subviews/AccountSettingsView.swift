import SwiftUI
import FirebaseAuth

public struct AccountSettingsView: View {
    // This is will be left as future work...
    @State private var viewAlert: Bool = false
    @State private var selectedTheme: Bool = false
    
    @Binding public var user: User?
    
    private var colorTheme: ColorThemes {
        return !self.selectedTheme ? .light : .dark
    }//colorTheme
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Account Settings")
                    .font(.title2)
                    .fontWeight(.bold)
                //Text
                
                Spacer()
                
                Image(systemName: "gear")
                    .font(.system(size: 32))
                    .foregroundStyle(Color.primary)
                //Image
            }//HStack
            
            ZStack {
                VStack(spacing: 0) {
                    ProfileToggleRowView(
                        toggle: self.$selectedTheme,
                        icon: "moon.fill",
                        prompt: "Theme (\(self.colorTheme == .light ? "Light" : "Dark"))"
                    )//ProfileToggleRowView
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                    //Rectangle
                    
                    ProfileButtonRowView(
                        icon: "power.circle.fill",
                        prompt: "Logout?",
                        btnLabel: "Logout"
                    ) {
                        self.viewAlert = true
                    }//ProfileButtonRowView
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
                icon: "check",
                heading: "Confirmation Required",
                message: "Are you sure about logging out?"
            ) {
                try? Auth.auth().signOut()
                
                self.user = nil
            }//AlertSheetView
        }//sheet
    }//body
}//AccountSettingsView
