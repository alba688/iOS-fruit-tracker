
import Foundation

// data structure identical to data from json
struct Fruit: Identifiable, Decodable {
    let id: Int
    let order: String
    let genus: String
    let name: String
    let family: String
    let nutritions: Nutritions
}

struct Nutritions: Decodable {
    let sugar: Double
    let protein: Double
    let fat: Double
    let carbohydrates: Double
    let calories: Int
}
