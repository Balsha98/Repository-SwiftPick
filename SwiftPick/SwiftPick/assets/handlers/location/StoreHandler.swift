import SwiftUI
import Foundation
@preconcurrency import MapKit
import CoreLocation

@MainActor
@Observable
public class StoreHandler {
    public var location: CLLocation?
    public var locationError: Bool = false
    public var permissionsError: Bool = false
    public var address: MKAddress? = nil
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    public init() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }//init
    
    public func startCurrentLocationUpdates() async throws {
        for try await locationUpdate in CLLocationUpdate.liveUpdates() {
            if locationUpdate.authorizationRequestInProgress {
                // Just wait.
            } else if locationUpdate.authorizationDenied || locationUpdate.authorizationRestricted {
                if !self.permissionsError {
                    await MainActor.run {
                        self.permissionsError = true
                    }//MainActor
                }//if
            } else {
                if !locationUpdate.locationUnavailable {
                    if self.permissionsError {
                        self.permissionsError = false
                    }//if
                    
                    self.location = locationUpdate.location
                    
                    if self.locationError {
                        self.locationError = false
                    }//if
                    
                    if self.location != nil {
                        self.address = try await reverseGeocode(location: self.location!)
                    }//if
                }//if
            }//if
        }//for
    }//startCurrentLocationUpdates
    
    public func reverseGeocode(location: CLLocation) async throws -> MKAddress? {
        if let request = MKReverseGeocodingRequest(location: location) {
            do {
                let mapItems = try await request.mapItems
                
                return mapItems.first?.address
            } catch {
                print("Error Caught - Error processing reverse-geocoding request.")
            }//do
        }//if
        
        return nil
    }//reverseGeocode
}//StoreHandler
