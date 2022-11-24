import SwiftUI

@main
struct FruitTrackerApp: App {
    //@StateObject var jsonModel = JsonModel()
    @StateObject var viewModel = FruitViewModel()
    
    var body: some Scene {
        WindowGroup {
            FruitTrackerView().environmentObject(viewModel)
        }
    }
}
