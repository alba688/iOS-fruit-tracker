import SwiftUI

struct LogView: View {
    
    @SectionedFetchRequest<String, DbFruitLog> (sectionIdentifier: \DbFruitLog.consumedDateAsString, sortDescriptors: [SortDescriptor(\DbFruitLog.date, order: .reverse), SortDescriptor(\.name),])
    private var dbFruitLog: SectionedFetchResults<String, DbFruitLog>
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(dbFruitLog) {
                    log in
                    Section(log.id) {
                        ForEach(log) {
                            fruit in
                            Text(fruit.name ?? "unknown")
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
