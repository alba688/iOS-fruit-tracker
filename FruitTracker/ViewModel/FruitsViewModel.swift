
import Foundation

class FruitsViewModel: ObservableObject {
    
    private let jsonModel = JsonModel()
    
    @Published var Fruits: [Fruit] = []
    
    @Published var familyNames: [String] = []
    @Published var ordersNames: [String] = []
    @Published var genusNames: [String] = []
    
    
    @MainActor
    func fetchFruits() async {
        do {
            let Fruits = try await jsonModel.loadFruits()
            familyNames = Fruits.map({$0.family}).unique
            ordersNames = Fruits.map({$0.order}).unique
            genusNames = Fruits.map({$0.genus}).unique
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


/* EXAMPLE COMBINING 2 ARRAYS INTO A DICTIONARY
var keysArray = [1, 2, 3, 4]
var valuesArray = ["apple", "ball", "dog", "cat"]
let dict = Dictionary(uniqueKeysWithValues: zip(keysArray, valuesArray))
for i in dict {
    print(i)
}
 */

