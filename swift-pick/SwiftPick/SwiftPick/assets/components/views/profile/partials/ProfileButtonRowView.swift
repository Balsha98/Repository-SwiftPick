import SwiftUI

public struct ProfileButtonRowView: View {
    public let icon: String
    public let prompt: String
    public let btnLabel: String
    public let action: () -> Void
    
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
                
                Button {
                    self.action()
                } label: {
                    Text(self.btnLabel)
                        .foregroundStyle(Color.primary)
                    //Text
                }//Button
            }//HStack
        }//HStack
        .padding(16)
    }//body
}//ProfileButtonRowView
