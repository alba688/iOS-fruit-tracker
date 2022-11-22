import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var jsonData: JsonModel



    
    /*mutating func assignColors() {
        var families = [String]()
        let colors = ["blue", "green", "red", "gray", "yellow", "brown", "cyan", "indigo", "mint", "orange","pink", "purple", "teal", "blue", "green", "red", "gray", "yellow", "brown", "cyan", "indigo", "mint", "orange","pink", "purple", "teal"]
        for fruit in jsonData.Fruits {
            if !families.contains(fruit.family) {
                families.append(fruit.family)
            }
        }
        print("unique families \(families)")
        for fam in families {
            colorFamilies[fam] =
            ForEach(colors)
            color in {
                return color
            }
        }
    }*/
    
    var body: some View {
        NavigationView {
            List {
                ForEach(jsonData.Fruits.sorted(by: { $0.id < $1.id} )) {
                    fruit in
                    NavigationLink {
                        DetailPage(fruit)
                    } label: {
                        Image(systemName: "square.fill").foregroundColor(.blue)
                        Text(fruit.name + " (id: \(fruit.id)) "+fruit.family)
                    }
                }
            }
            .task {
                await jsonData.loadFruits()
            }
            .navigationTitle("List of fruits")
        }
    }
}

struct FruitListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(JsonModel())
    }
}
