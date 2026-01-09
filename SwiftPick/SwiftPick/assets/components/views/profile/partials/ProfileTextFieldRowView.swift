import SwiftUI

public struct ProfileTextFieldRowView: View {
    @Binding public var text: String
    
    public let icon: String
    public let prompt: String
    public let keyboard: UIKeyboardType
    public let isDisabled: Bool
    
    public init(
        text: Binding<String>,
        icon: String,
        prompt: String,
        keyboard: UIKeyboardType,
        isDisabled: Bool = false
    ) {
        self._text = text
        self.icon = icon
        self.prompt = prompt
        self.keyboard = keyboard
        self.isDisabled = isDisabled
    }//init
    
    public var body: some View {
        HStack(spacing: 24) {
            Image(systemName: self.icon)
                .font(.title2)
                .foregroundStyle(Color.primary)
            //Image
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(self.prompt):")
                    .font(.system(size: 14))
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
                .opacity(self.isDisabled ? 0.4 : 1)
                .disabled(self.isDisabled)
            }//VStack
        }//HStack
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }//body
}//ProfileTextFieldRowView
