import SwiftUI

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
