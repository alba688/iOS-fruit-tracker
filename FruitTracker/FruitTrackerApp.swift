import SwiftUI

@main
struct FruitTrackerApp: App {
    @StateObject var jsonModel = JsonModel()
    
    var body: some Scene {
        WindowGroup {
            FruitTrackerView().environmentObject(jsonModel)
        }
    }
}
