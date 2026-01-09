import SwiftUI

public struct ProfileDateRowView: View {
    @Binding public var date: Date
    
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
                
                DatePicker(
                    self.prompt,
                    selection: self.$date,
                    displayedComponents: .date
                )//DatePicker
                .labelsHidden()
                .colorScheme(.light)
                .clipShape(Capsule())
            }//HStack
        }//HStack
        .padding(16)
    }//body
}//ProfileDateRowView
