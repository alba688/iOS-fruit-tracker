import Foundation


let url = "https://fruityvice.com/api/fruit/all"

// create a class of data from json that is observable within application
final class JsonModel: ObservableObject {

    // variables
    @Published var Fruits: [Fruit] = []
    @Published var familyNames: [String] = []
    @Published var ordersNames: [String] = []
    @Published var genusNames: [String] = []
    
    // function to load data from HTTP request
    func loadFruits() async {
        
        // connection to server
        guard let fruitUrl = URL(string: url) else {
            fatalError("Error. No response from server: \n\n\(url)")
        }
        do {
            // download + decode data from server
            let (data, _) = try await URLSession.shared.data(from: fruitUrl)
            Fruits = try JSONDecoder().decode([Fruit].self, from: data)
            familyNames = Fruits.map({$0.family}).unique
            ordersNames = Fruits.map({$0.order}).unique
            genusNames = Fruits.map({$0.genus}).unique
        }
        catch {
            fatalError("Error. Cannot decode content from: \n\n\(url)")
        }
    }
}

private extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}



// placeholder for data
let fruit = Fruit(id: 0, order: "FruitOrder", genus: "FruitGenus", name: "FruitName", family: "FruitFamily", nutritions: nutritions)
let nutritions = Nutritions(sugar: 12.0, protein: 0, fat: 0, carbohydrates: 0, calories: 0)
