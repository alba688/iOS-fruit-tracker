import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var jsonData: JsonModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(jsonData.Fruits) {
                    fruit in
                    NavigationLink {
                        DetailPage(fruit)
                    } label: {
                        Text(fruit.name + " (id: \(fruit.id))")
                    }
                }
            }.task {
                await jsonData.loadFruits()
            }
            .navigationTitle("List of fruits")
        }
    }
}

struct FruitListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(JsonModel())
    }
}
