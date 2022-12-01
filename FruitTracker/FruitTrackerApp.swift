import SwiftUI
// This Project Uses XCode 14.1 and Swift 5.7.1

@main
struct FruitTrackerApp: App {
    
    @StateObject var viewModel = FruitViewModel()
    @Environment(\.scenePhase) var myScene
    
    let db = DataModel.myShared
    
    var body: some Scene {
        WindowGroup {
            FruitTrackerView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, db.container.viewContext)
        }
        .onChange(of: myScene) {
            myScene in
            db.save()
        }
    }
}
