import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var jsonData: JsonModel
    
    func getFamilyColor(for family: String) -> Color{
        if family == "Actinidiaceae" {
            return Color(red: 0.5, green: 0.5, blue: 0.8)
        }
        else if family == "Anacardiaceae" {
            return Color(red: 0.7, green: 0.3, blue: 0.6)
        }
        else if family == "Bromeliaceae" {
            return Color(red: 0.9, green: 0.01, blue: 0.3)
        }
        else if family == "Cactaceae" {
            return Color(red: 0.9, green: 0.8, blue: 0.3)
        }
        else if family == "Caricaceae" {
            return Color(red: 1.0, green: 0.5, blue: 0.1)
        }
        else if family == "Cucurbitaceae" {
            return Color(red: 0.9, green: 0.0, blue: 0.0)
        }
        else if family == "Ebenaceae" {
            return Color(red: 1.0, green: 0.9, blue: 0.2)
        }
        else if family == "Ericaceae" {
            return Color(red: 0.8, green: 0.2, blue: 1.0)
        }
        else if family == "Grossulariaceae" {
            return Color(red: 0.7, green: 1.0, blue: 0.4)
        }
        else if family == "Lauraceae" {
            return Color(red: 0.7, green: 0.7, blue: 0.8)
        }
        else if family == "Lythraceae" {
            return Color(red: 0.6, green: 0.9, blue: 0.3)
        }
        else if family == "Malvaceae" {
            return Color(red: 0.6, green: 0.9, blue: 1.0)
        }
        else if family == "Moraceae" {
            return Color(red: 0.6, green: 0.2, blue: 0.9)
        }
        else if family == "Musaceae" {
            return Color(red: 0.6, green: 0.4, blue: 0.0)
        }
        else if family == "Myrtaceae" {
            return Color(red: 0.4, green: 0.8, blue: 0.1)
        }
        else if family == "Passifloraceae" {
            return Color(red: 0.6, green: 0.0, blue: 0.1)
        }
        else if family == "Rosaceae" {
            return Color(red: 0.4627, green: 0.8392, blue: 1.0)
        }
        else if family == "Rutaceae" {
            return Color(red: 0.4, green: 1.0, blue: 0.7)
        }
        else if family == "Sapindaceae" {
            return Color(red: 0.3, green: 0.4, blue: 0.9)
        }
        else if family == "Solanaceae" {
            return Color(red: 0.7, green: 1.0, blue: 0.6)
        }
        else if family == "Vitaceae" {
            return Color(red: 0.3, green: 0.9, blue: 0.8)
        }
        else {
            return Color.black
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(jsonData.Fruits.sorted(by: { $0.id < $1.id} )) {
                    fruit in
                    NavigationLink {
                        DetailPage(fruit)
                    }
                    label: {
                        Image(systemName: "square.fill").foregroundColor( getFamilyColor(for: "\(fruit.family)") )
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
