import SwiftUI

struct FruitTrackerView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house.fill")
            }
            ListView().tabItem {
                Label("Fruits", systemImage: "list.bullet")
            }
            CategoriesView().tabItem {
                Label("Categories", systemImage: "folder.fill")
            }
            LogView().tabItem {
                Label("Tracker", systemImage: "list.clipboard.fill")
            }
        }
    }
}

struct FruitTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        FruitTrackerView()
    }
}
