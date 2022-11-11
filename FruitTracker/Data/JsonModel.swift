import Foundation

let url = "https://fruityvice.com/api/fruit/all"

// data structure identical to data from json
struct Fruit: Identifiable, Decodable
{
    let id: Int
    let order: String
    let genus: String
    let name: String
    let family: String
    let nutritions: Nutritions
}

struct Nutritions: Decodable
{
    let sugar: Double
    let protein: Double
    let fat: Double
    let carbohydrates: Double
    let calories: Int
}

// create a class of data from json that is observable within application
final class JsonModel: ObservableObject {
    @Published var Fruits: [Fruit] = []
    
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
        }
        catch {
            fatalError("Error. Cannot decode content from: \n\n\(url)")
        }
    }
}

// placeholder for data
let fruit = Fruit(id: 0, order: "FruitOrder", genus: "FruitGenus", name: "FruitName", family: "FruitFamily", nutritions: nutritions)
let nutritions = Nutritions(sugar: 0, protein: 0, fat: 0, carbohydrates: 0, calories: 0)
