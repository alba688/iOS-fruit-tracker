import SwiftUI

struct LogView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var fruits: FetchedResults<DbFruitLog>
    
    @State var groupedByDate: [String: [String]] = [:]

    var body: some View {
        NavigationView {
            List {
                ForEach(fruits) {
                    fruit in
                    VStack(alignment: .leading) {
                        Text(fruit.name ?? "Unknown")
                        HStack {
                            Text(getFruitDate(date: fruit.date ?? Date()))
                        }
                    }
                }
            }.navigationTitle("Fruit Log")
        }
    }
    
    func getFruitDate(date: Date) -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let theDate = "\(day)/\(month)/\(year)"
        return theDate
    }
}

struct FruitLogView_Previews: PreviewProvider {
    static var previews: some View {
        
        LogView().environment(\.managedObjectContext, DataModel.myShared.container.viewContext)
    }
}
