import SwiftUI
import CoreLocation
import MapKit

public struct StoresFullScreenView: View {
    @State private var stores: [Store] = []
    @State private var selectedStoreId: Int? = nil
    @State private var viewMapItemInfo: Bool = false
    @State private var selectedSegment: Int = 0
    @State private var selectedMapStyle: MapStyle = .standard
    @State private var mapCameraPosition: MapCameraPosition = .automatic
    @State private var mapDirectionRoute: MKRoute?
    @State private var mapStyles: [MapStyleType] = MapStyleTypes().styles
    
    @Binding public var viewStores: Bool
    
    public let storeHandler: StoreHandler = StoreHandler()
    
    public let requestHandler: RequestHandler

    private var location: CLLocation {
        return storeHandler.location ?? CLLocation.rit
    }//location
    
    private var locationError: Bool {
        return self.storeHandler.locationError
    }//locationError
    
    private var permissionsError: Bool {
        return self.storeHandler.permissionsError
    }//permissionsError
    
    public var body: some View {
        ZStack {
            if self.stores.isEmpty {
                DataLoadingView()
            } else {
                ZStack(alignment: .topLeading) {
                    Button {
                        self.viewStores = false
                    } label: {
                        Image(systemName: "chevron.down")
                            .font(.callout)
                        //Image
                    }//Button
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.primary)
                    .clipShape(Circle())
                    .cornerRadius(4)
                    .offset(x: 16, y: 16)
                    .shadow(
                        color: .black.opacity(0.2),
                        radius: 4, x: 0, y: 4
                    )//shadow
                    .zIndex(2)
                    
                    Map(position: self.$mapCameraPosition, selection: self.$selectedStoreId) {
                        UserAnnotation()
                        
                        ForEach(self.stores) { store in
                            Marker(
                                store.title,
                                systemImage: "storefront.fill",
                                coordinate: store.coordinate
                            )//Marker
                        }//ForEach
                        .annotationTitles(.hidden)
                        .tint(Color.primary)
                    }//Map
                    .mapStyle(self.selectedMapStyle)
                    .mapControls {
                        MapUserLocationButton()
                        
                        MapCompass()
                    }//mapControls
                    .safeAreaInset(edge: .bottom) {
                        VStack(spacing: 0) {
                            if let selectedStoreId = self.selectedStoreId {
                                if let selectedStore = self.stores.first(where: { $0.id == selectedStoreId }) {
                                    StoreDetailsView(
                                        selectedStore: selectedStore,
                                        mapDirectionRoute: self.mapDirectionRoute
                                    )//StoreDetailsView
                                    
                                    Rectangle()
                                        .fill(Color.primary)
                                        .frame(height: 2)
                                    //Rectangle
                                }//if
                            }//if
                            
                            StoresMapPickerView(
                                selectedSegment: self.$selectedSegment,
                                mapCameraPosition: self.$mapCameraPosition,
                                mapStyles: self.$mapStyles
                            )//StoresMapPickerView
                        }//VStack
                    }//safeAreaInset
                    .zIndex(1)
                }//ZStack
                .onChange(of: self.selectedStoreId) {
                    self.viewMapItemInfo = true
                    
                    self.getRouteDirections()
                }//onChange
                .onChange(of: self.selectedSegment) {
                    self.selectedMapStyle = self.mapStyles[self.selectedSegment].style
                }//onChange
                .task {
                    do {
                        try await storeHandler.startCurrentLocationUpdates()
                    } catch {
                        self.storeHandler.locationError = true
                    }//do
                }//task
            }//if
        }//ZStack
        .onAppear {
            if let stores = self.requestHandler.data["stores"] as? Stores {
                self.stores = stores.data
            }//if
        }//task
    }//body
    
    public func getRouteDirections() {
        self.mapDirectionRoute = nil
        
        let request = MKDirections.Request()
        request.source = MKMapItem(location: CLLocation.rit, address: nil)
        request.destination = MKMapItem(location: self.location, address: nil)
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            self.mapDirectionRoute = response?.routes.first
        }//Task
    }//getRouteDirections
}//StoresFullScreenView
