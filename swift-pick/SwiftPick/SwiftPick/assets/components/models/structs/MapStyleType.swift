import SwiftUI
import MapKit

public struct MapStyleType {
    public let label: String
    public let style: MapStyle
}//MapStyle

public struct MapStyleTypes {
    public let styles: [MapStyleType] = [
        MapStyleType(label: "Standard", style: .standard),
        MapStyleType(label: "Satellite", style: .imagery),
        MapStyleType(label: "Hybrid", style: .hybrid)
    ]//styles
}//MapStyleTypes
