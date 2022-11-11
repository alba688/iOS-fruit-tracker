import SwiftUI

@main
struct FruitTrackerApp: App {
    @StateObject var json = JsonModel()
    
    var body: some Scene {
        WindowGroup {
            FruitTrackerView().environmentObject(json)
        }
    }
}
