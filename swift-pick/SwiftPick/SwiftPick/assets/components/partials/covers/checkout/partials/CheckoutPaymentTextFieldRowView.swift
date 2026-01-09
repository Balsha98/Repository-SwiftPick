import SwiftUI

public struct CheckoutPaymentTextFieldRowView: View {
    @Binding public var text: String
    
    public let prompt: String
    public let keyboard: UIKeyboardType
    public let icon: String
    
    public var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(self.prompt):")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                //Text
    
                TextField(
                    self.prompt,
                    text: self.$text,
                    prompt: Text(
                        self.prompt
                    )//Text
                        .foregroundStyle(.black.opacity(0.4))
                )//TextField
                .tint(.black)
                .textInputAutocapitalization(.never)
                .keyboardType(self.keyboard)
                .autocorrectionDisabled()
            }//VStack
            
            Spacer()
            
            Image(systemName: self.icon)
                .font(.title2)
                .foregroundStyle(Color.primary)
            //Image
        }//ZStack
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .border(Color.primary, width: 2)
        .cornerRadius(4)
    }//body
}//CheckoutPaymentTextFieldRowView
