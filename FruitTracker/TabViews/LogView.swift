import SwiftUI

struct LogView: View {
    
    @SectionedFetchRequest<String, DbFruitLog> (sectionIdentifier: \DbFruitLog.fruitDateToString, sortDescriptors: [SortDescriptor(\DbFruitLog.date, order: .reverse), SortDescriptor(\.name),])
    private var dbFruitLog: SectionedFetchResults<String, DbFruitLog>
    
    struct CalorieLog {
        var date: String
        var calories: Double
        var sugar: Double
        var carb: Double
        var protein: Double
        var fat: Double
    }
    
    @State var calorieLog: [CalorieLog] = []
    
    func logCalories(date: String, cal: Double, sugar: Double, carb: Double, protein: Double, fat: Double) {
        calorieLog.append(CalorieLog(date: date, calories: cal, sugar: sugar, carb: carb, protein: protein, fat: fat))
    }
    
    var body: some View {
                
        NavigationView {
            List {
                ForEach(dbFruitLog) {
                    log in
                    Section(log.id) {
                        ForEach(log) {
                            fruit in
                            HStack {
                                Text(fruit.name ?? "unknown")
                                Spacer()
                                Text("Calories: \(fruit.calories, specifier: "%.2f")").font(.caption)
                            }
                            .swipeActions(content: {
                                Button(role: .destructive, action: {
                                    DataModel.myShared.deleteFruit(fruit: fruit)
                                }, label: {
                                    Image(systemName: "trash")
                                })
                            })
                            .listRowSeparator(.hidden, edges: .top)
                            .onAppear {
                                logCalories(date: fruit.fruitDateToString, cal: fruit.calories, sugar: fruit.sugar, carb: fruit.carbohydrates, protein: fruit.protein, fat: fruit.fat)
                            }
                        
                        }
                        VStack {
                            HStack{
                                Text("Daily Totals").font(.title2)
                                Spacer()
                            }
        
                            HStack {
                                Spacer()
                                Text("Sugar: \(calorieLog.filter({ $0.date == "\(log.id)" }).map{$0.sugar}.reduce(0, +), specifier: "%.2f")").font(.caption)
                                Text("Calories: \(calorieLog.filter({ $0.date == "\(log.id)" }).map{$0.calories}.reduce(0, +), specifier: "%.2f")").font(.caption)

                            }.listRowSeparatorTint(.red, edges: .top)
                            HStack {
                                Spacer()
                                Text("Carbohydrates: \(calorieLog.filter({ $0.date == "\(log.id)" }).map{$0.carb}.reduce(0, +), specifier: "%.2f")").font(.caption)
                                Text("Protein: \(calorieLog.filter({ $0.date == "\(log.id)" }).map{$0.protein}.reduce(0, +), specifier: "%.2f")").font(.caption)
                                Text("Fat: \(calorieLog.filter({ $0.date == "\(log.id)" }).map{$0.fat}.reduce(0, +), specifier: "%.2f")").font(.caption)

                            }.listRowSeparator(.hidden, edges: .top)
                        }
                    }
                }
            }
            .navigationTitle("Fruit Log")
        }
    }
}


 extension DbFruitLog {
    @objc var fruitDateToString: String {
        date!.formatted(date: .abbreviated, time: .omitted)
    }
}
 

extension DbFruitLog {
    @objc var formatDate: Date {
        let calendar = Calendar.current

        var components = calendar.dateComponents([.year, .month, .day], from: date!)
        components.hour = 00
        components.minute = 00
        components.second = 00

        return calendar.date(from: components)!
    }
}
 

struct FruitLogView_Previews: PreviewProvider {
    static var previews: some View {
        
        LogView().environment(\.managedObjectContext, DataModel.myShared.container.viewContext)
    }
}
