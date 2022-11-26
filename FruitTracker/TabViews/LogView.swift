import SwiftUI

struct LogView: View {
    
    @SectionedFetchRequest<String, DbFruitLog> (sectionIdentifier: \DbFruitLog.consumedDateAsString, sortDescriptors: [SortDescriptor(\DbFruitLog.date, order: .reverse), SortDescriptor(\.name),])
    private var dbFruitLog: SectionedFetchResults<String, DbFruitLog>
    
    @State private var dailyCalories = [Int]()
    @State private var dailySugar = [Int]()
    @State private var dailyCarbohydrates = [Int]()
    @State private var dailyProtein = [Int]()
    @State private var dailyFat = [Int]()
    
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
                                Text("Calories: \(Int(fruit.calories))g").font(.caption)
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
                                dailyCalories.append(Int(fruit.calories))
                                dailySugar.append(Int(fruit.sugar))
                                dailyCarbohydrates.append(Int(fruit.carbohydrates))
                                dailyProtein.append(Int(fruit.protein))
                                dailyFat.append(Int(fruit.fat))
                            }
                            
                        }
                        VStack {
                            HStack{
                                Text("Daily Totals").font(.title2)
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("Calories: \(dailyCalories.reduce(0, +))g").font(.footnote)
                                Text("Sugar: \(dailySugar.reduce(0, +))g").font(.footnote)
                            }.listRowSeparatorTint(.red, edges: .top)
                            HStack {
                                Spacer()
                                Text("Carbohyrates: \(dailyCarbohydrates.reduce(0, +))g").font(.footnote)
                                Text("Protein: \(dailyProtein.reduce(0, +))g").font(.footnote)
                                Text("Fat: \(dailyFat.reduce(0, +))g").font(.footnote)
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
    @objc var consumedDateAsString: String {
        date!.formatted(date: .abbreviated, time: .omitted)
    }
}

struct FruitLogView_Previews: PreviewProvider {
    static var previews: some View {
        
        LogView().environment(\.managedObjectContext, DataModel.myShared.container.viewContext)
    }
}
