import SwiftUI
import MapKit

struct StoresMapPickerView: View {
    @Binding public var selectedSegment: Int
    @Binding public var mapCameraPosition: MapCameraPosition
    @Binding public var mapStyles: [MapStyleType]
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                self.mapCameraPosition = .automatic
            } label: {
                Image(systemName: "minus.magnifyingglass")
                    .font(.callout)
                    .foregroundStyle(.white)
                //Image
            }//Button
            .frame(width: 64, height: 32)
            .background(Color.primary)
            .clipShape(Capsule())
            
            Picker(selection: self.$selectedSegment, label: EmptyView()) {
                ForEach(0..<self.mapStyles.count, id: \.self) { i in
                    Text(self.mapStyles[i].label)
                        .tag(i)
                    //Text
                }//ForEach
            }//Picker
            .pickerStyle(.segmented)
        }//HStack
        .padding()
        .background(.regularMaterial)
    }//body
}//StoresMapPickerView
