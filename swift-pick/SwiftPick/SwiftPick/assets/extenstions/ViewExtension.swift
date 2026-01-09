import SwiftUI

extension View {
    public func goToDeviceSettings() {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
        
        UIApplication.shared.open(url)
    }//goToDeviceSettings
}//View
