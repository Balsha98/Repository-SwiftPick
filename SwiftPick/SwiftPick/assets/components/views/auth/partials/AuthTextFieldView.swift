import SwiftUI

public struct AuthTextFieldView: View {
    @Binding public var text: String
    
    public let prompt: String
    public let width: Double
    public let contentType: UITextContentType
    public let keyboard: UIKeyboardType
    public let icon: String
    
    public var body: some View {
        ZStack(alignment: .trailing) {
            TextField(
                self.prompt,
                text: self.$text,
                prompt: Text(
                    self.prompt
                )//Text
                .font(.callout)
                .foregroundStyle(Color.primary)
            )//TextField
            .frame(width: self.width)
            .padding(12)
            .tint(.black)
            .border(Color.primary, width: 2)
            .textInputAutocapitalization(.never)
            .textContentType(self.contentType)
            .keyboardType(self.keyboard)
            .autocorrectionDisabled()
            .cornerRadius(4)
            
            Image(systemName: self.icon)
                .offset(x: -12)
                .font(.callout)
                .foregroundStyle(Color.primary)
            //Image
        }//ZStack
    }//body
}//AuthTextFieldView
