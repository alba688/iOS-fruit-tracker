import Foundation

class FruitViewModel: ObservableObject {
    
    private let jsonModel = JsonModel()

    // variables
    @Published var Fruits: [Fruit] = []
    @Published var familyNames: [String] = []
    @Published var ordersNames: [String] = []
    @Published var genusNames: [String] = []

    @MainActor
    func loadFruits() async {
        do {
            Fruits = try await jsonModel.fetchFruits()
            familyNames = Fruits.map({$0.family}).unique
            ordersNames = Fruits.map({$0.order}).unique
            genusNames = Fruits.map({$0.genus}).unique
        } catch {
            fatalError("Error getting content from jsonModel.fetchFruits")
        }
    }
    
    @MainActor
    func loadFamilyFruits(familyName: String) async {
        do {
            Fruits = try await jsonModel.fetchFamily(familyName: familyName)
        } catch {
            fatalError("Error getting content from jsonModel.fetchFamily")
        }
    }
    
    @MainActor
    func loadOrderFruits(orderName: String) async {
        do {
            Fruits = try await jsonModel.fetchOrder(orderName: orderName)
        } catch {
            fatalError("Error getting content from jsonModel.fetchOrder")
        }
    }
    
    @MainActor
    func loadGenusFruits(genusName: String) async {
        do {
            Fruits = try await jsonModel.fetchGenus(genusName: genusName)
        } catch {
            fatalError("Error getting content from jsonModel.fetchGenus")
        }
    }
    
    
}
// extension to remove duplicates from array of family, order, genus names
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

// placeholder for data previews
let fruit = Fruit(id: 0, order: "GrapeOrder", genus: "GrapeGenus", name: "Grape", family: "GrapeFamily", nutritions: nutritions)
let nutritions = Nutritions(sugar: 12.0, protein: 1.0, fat: 0.2, carbohydrates: 30.0, calories: 120)
let familyText = "Musaceae"
let orderText = "Zingiberales"
let genusText = "Sellowiana"
