import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var jsonData: JsonModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(jsonData.Fruits.sorted(by: { $0.id < $1.id} )) {
                    fruit in
                    NavigationLink {
                        DetailPage(fruit)
                    } label: {
                        Image(systemName: "square.fill")
                        Text(fruit.name + " (id: \(fruit.id)) "+fruit.family)
                    }
                }
            }
            .task {
                await jsonData.loadFruits()
                await jsonData.loadFams()
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
