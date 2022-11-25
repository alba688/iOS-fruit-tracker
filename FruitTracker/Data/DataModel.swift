import Foundation
import CoreData

struct DataModel {

    // shared with entire app
    static let myShared = DataModel()
    
    // storage for core data
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Database")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores {
            (description, error) in
            if let myError = error as NSError? {
                print("Error. Could not open database \(myError), \(myError.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func addFruit(fruit: Fruit) {
        let myContext = container.viewContext
        let myFruit = DbFruitLog(context: myContext)
        
        myFruit.id = UUID()
        myFruit.name = fruit.name
        myFruit.date = Date()
        myFruit.carbohydrates = fruit.nutritions.carbohydrates
        myFruit.calories = Double(fruit.nutritions.calories)
        myFruit.protein = fruit.nutritions.protein
        myFruit.sugar = fruit.nutritions.sugar
        myFruit.fat = fruit.nutritions.fat
    }
    
    func save() {
        let myContext = container.viewContext
        
        if myContext.hasChanges {
            do {
                try myContext.save()
            }
            catch {
                print("Error, could not save changes \(error), \(error.localizedDescription)")
            }
        }
    }
    
    
    
}
