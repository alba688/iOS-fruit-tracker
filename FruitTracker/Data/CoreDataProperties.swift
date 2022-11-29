import Foundation
import CoreData

//DbFruitLog+CoreDataProperties.swift
extension DbFruitLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DbFruitLog> {
        return NSFetchRequest<DbFruitLog>(entityName: "DbFruitLog")
    }

    @NSManaged public var calories: Double
    @NSManaged public var carbohydrates: Double
    @NSManaged public var date: Date?
    @NSManaged public var fat: Double
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var protein: Double
    @NSManaged public var sugar: Double
    
    var wrappedName: String {
        name ?? "Unknown"
    }

}

extension DbFruitLog : Identifiable {

}
