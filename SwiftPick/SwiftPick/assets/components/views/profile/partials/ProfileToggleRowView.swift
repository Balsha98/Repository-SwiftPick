import SwiftUI

public struct ProfileToggleRowView: View {
    @Binding public var toggle: Bool
    
    public let icon: String
    public let prompt: String
    
    public var body: some View {
        HStack {
            Image(systemName: self.icon)
                .font(.title2)
                .foregroundStyle(Color.primary)
            //Image
            
            HStack {
                Text("\(self.prompt):")
                    .fontWeight(.semibold)
                //Text
                
                Spacer()
                
                Toggle(isOn: self.$toggle) {
                    EmptyView()
                }//Toggle
                .toggleStyle(SwitchToggleStyle(tint: .green))
            }//HStack
        }//HStack
        .padding(16)
    }//body
}//ProfileToggleRowView
