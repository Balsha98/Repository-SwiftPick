import SwiftUI
import MapKit

public struct StoreDetailsView: View {
    public var selectedStore: Store
    public var mapDirectionRoute: MKRoute?
    
    private var travelTime: String? {
        guard let mapDirectionRoute = self.mapDirectionRoute else { return nil }
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: mapDirectionRoute.expectedTravelTime)
    }//travelTime
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Location Overview")
                        .fontWeight(.semibold)
                    //Text
                    
                    UnevenRoundedRectangle(
                        topLeadingRadius: 4,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 4
                    )//UnevenRoundedRectangle
                        .fill(Color.primary)
                        .frame(width: 48, height: 2)
                }//VStack
                
                Spacer()
                
                Button {
                    let mkMapItem = MKMapItem(location: self.selectedStore.location, address: nil)
                    
                    mkMapItem.name = self.selectedStore.storeCity
                    
                    let mkItemOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                    
                    mkMapItem.openInMaps(launchOptions: mkItemOptions)
                } label: {
                    ZStack {
                        Image(systemName: "map.fill")
                            .foregroundStyle(.white)
                            .zIndex(2)
                        //Image
                        
                        Circle()
                            .fill(Color.primary)
                            .frame(width: 32)
                        //Circle
                    }//ZStack
                }//Button
            }//HStack
            
            VStack(spacing: 4) {
                HStack {
                    Text("City Name:")
                        .fontWeight(.semibold)
                    //Text
                    
                    Spacer()
                    
                    Text(self.selectedStore.storeCity)
                        .font(.title2)
                    //Text
                }//HStack
                
                HStack {
                    Text("Travel Time:")
                        .fontWeight(.semibold)
                    //Text
                    
                    Spacer()
                    
                    Text(self.travelTime == nil ? "Calculating route..." : self.travelTime!)
                        .font(.callout)
                    //Text
                }//HStack
            }//VStack
        }//VStack
        .padding()
        .background(.regularMaterial)
    }//body
}//StoreDetailsView
