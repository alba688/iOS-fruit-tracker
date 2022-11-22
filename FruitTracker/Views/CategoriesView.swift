import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var jsonData: JsonModel
    
    /*var Families: [String] = []
    
    func loadFamilies() async {
        for fruit in jsonData.Fruits {
            if !Families.contains(fruit.family) {
                Families.append(fruit.family)
            }
        }
        print(Families)
     //{$0.family != $1.family}
    }*/
    
    var body: some View {
    
        NavigationView {
            List {
                Section(header: Text("Families")) {
                    ForEach(jsonData.Fruits) {
                        fruit in
                        Text(fruit.family)
                    }
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
