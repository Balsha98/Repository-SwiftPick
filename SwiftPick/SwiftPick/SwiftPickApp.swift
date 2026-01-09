import UIKit
import SwiftUI
import Firebase
import SwiftData

@main
public struct SwiftPickApp: App {
    public init() {
        FirebaseApp.configure()
    }//init
    
    public var body: some Scene {
        WindowGroup {
            MainView()
        }//WindowGroup
        .modelContainer(for: [FavoriteItem.self])
    }//body
}//SwiftPickApp
