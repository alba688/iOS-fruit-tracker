import SwiftUI

struct LogView: View {
    
    //@FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var fruits: FetchedResults<DbFruitLog>
    @SectionedFetchRequest<Date, DbFruitLog> (sectionIdentifier: \.date!,
        sortDescriptors: [
            SortDescriptor(\.date),
            SortDescriptor(\.name)
    ])
    private var fruitLog: SectionedFetchResults<Date, DbFruitLog>
    
    //@State var groupedByDate: [String: [String]] = [:]

    var body: some View {
        NavigationView {
            List {
                ForEach(fruitLog) {
                    fruit in
                    Section(fruit.id.formatted(date: .numeric, time: .omitted)) {
                        ForEach(fruit) {
                            name in
                            Text(name.name ?? "unknown")
                        }
                    }
                }
            }.navigationTitle("Fruit Log")
        }
    }
}

struct FruitLogView_Previews: PreviewProvider {
    static var previews: some View {
        
        LogView().environment(\.managedObjectContext, DataModel.myShared.container.viewContext)
    }
}
