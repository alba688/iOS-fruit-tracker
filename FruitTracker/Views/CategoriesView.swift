import SwiftUI

struct Families: Codable {
    var family: [Family]
}

struct Family: Codable {
    var name: String
}

struct CategoriesView: View {
    @EnvironmentObject var jsonData: JsonModel
    @State private var family = [Family]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(jsonData.Fruits) {
                    fruit in
                    Text(fruit.family)
                }
            }.task {
                await jsonData.loadFruits()
            }
            .navigationTitle("Categories")
        }
    }
}


struct FruitGroupsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView().environmentObject(JsonModel())
    }
}
