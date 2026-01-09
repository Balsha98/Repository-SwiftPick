import Foundation
import CoreLocation

public class Store: NSObject, Identifiable, Codable {
    public let id: Int
    public let storeCity: String
    public let storeState: String
    public let storeStateLogo: String
    public let storeLat: Double
    public let storeLng: Double
    
    public enum CodingKeys: String, CodingKey {
        case id = "storeId"
        case storeCity
        case storeState
        case storeStateLogo
        case storeLat
        case storeLng
    }//CodingKeys
    
    public var title: String {
        return self.storeCity
    }//title
    
    public var subtitle: String {
        return self.storeState
    }//subtitle
    
    public var location: CLLocation {
        return CLLocation(
            latitude: self.storeLat,
            longitude: self.storeLng
        )//return
    }//location
    
    public var coordinate: CLLocationCoordinate2D {
        return self.location.coordinate
    }//coordinate
}//Store

public class Stores: Codable {
    public var data: [Store]
}//Stores
