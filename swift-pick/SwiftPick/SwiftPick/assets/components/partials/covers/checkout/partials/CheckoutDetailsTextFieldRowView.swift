import SwiftUI

public struct CheckoutDetailsTextFieldRowView<Content: View>: View {
    @Binding public var text: String
    
    public let prompt: String
    public let keyboard: UIKeyboardType
    public let notice: () -> Content
    
    public init(
        text: Binding<String>,
        prompt: String,
        keyboard: UIKeyboardType,
        notice: @escaping () -> Content = { EmptyView() }
    ) {
        self._text = text
        self.prompt = prompt
        self.keyboard = keyboard
        self.notice = notice
    }//init
    
    public var body: some View {
        VStack(spacing: 8) {
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
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .border(Color.primary, width: 2)
            .cornerRadius(4)
            
            notice()
        }//VStack
    }//body
}//CheckoutDetailsTextFieldRowView
