import SwiftUI

public struct ProfilePickerRowView: View {
    @Binding public var selectedPickerIndex: Int
    
    public let icon: String
    public let prompt: String
    public let pickerCases: [Any]
    
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
                
                Picker(selection: self.$selectedPickerIndex, label: EmptyView()) {
                    ForEach(0..<self.pickerCases.count, id: \.self) { i in
                        if self.pickerCases[i] is GenderCase {
                            Text((self.pickerCases[i] as! GenderCase).label)
                                .tag(i)
                            //Text
                        }//if
                    }//ForEach
                }//Picker
                .pickerStyle(.menu)
                .tint(.black)
            }//HStack
        }//HStack
        .padding(16)
    }//body
}//ProfilePickerRowView
