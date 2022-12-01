import SwiftUI
import CoreData

struct DetailPage: View {
    var fruit: Fruit
    @FetchRequest var fetchRequest: FetchedResults<DbFruitLog>
    init(_ fruit: Fruit) {
        self.fruit = fruit
        _fetchRequest = FetchRequest<DbFruitLog>(sortDescriptors: [], predicate: NSPredicate(format: "(name CONTAINS %@)", fruit.name))
     }
    
     
     @State var highSugar = false
     @State var animateColor = false
     @State var isConfirmed = false
     @State var isCompleted = false
     @State var isAnimated = false

 
     private func checkSugar() {
         if (fruit.nutritions.sugar >= 10.0) {
             highSugar = true
             withAnimation(.easeInOut(duration: 2).repeatForever()){
                 animateColor = true
             }
         }
     }
    
    private func checkAmount() {
        if (fetchRequest.count > 0) {
            isAnimated = true
        }
    }
    
    func getNumber() -> Int{
        return fetchRequest.count
    }

     var body: some View {
         ZStack {
             VStack (alignment: .leading) {
                 List {
                     Text("You've eaten \(fetchRequest.count ) \(fruit.name)'s")
                     Section("Classification") {
                         Text("Order: \(fruit.order)")
                         Text("Family: \(fruit.family)")
                         Text("Genus: \(fruit.genus)")
                     }
                     Section("Nutrition per 100 grams") {
                         Text("Carbohydrates: \(fruit.nutritions.carbohydrates, specifier: "%.2f")g")
                         Text("Protein: \(fruit.nutritions.protein, specifier: "%.2f")g")
                         Text("Fat: \(fruit.nutritions.fat, specifier: "%.2f")g")
                         Text("Sugar: \(fruit.nutritions.sugar, specifier: "%.2f")g")
                     }
                     HStack {
                         Text("* HIGH SUGAR *").foregroundColor(highSugar ? .red.opacity(1.0) : .red.opacity(0.0))
                         Spacer()
                     
                         Button ("+ Eat Fruit") {
                             isConfirmed = true
                         }
                         .buttonStyle(.borderedProminent).foregroundColor(.white)
                         .confirmationDialog("Eat Fruit", isPresented: $isConfirmed) {
                             Button("Eat 100g of this fruit") {
                                 DataModel.myShared.addFruit(fruit: fruit)
                                 DataModel.myShared.save()
                                 isCompleted = true
                             }
                         }.alert("Fruit was eaten", isPresented: $isCompleted) {
                             Button("OK", role: .cancel) {}
                         }
                     }
                 }
                 .animation(nil, value: UUID())
                 .navigationTitle("\(fruit.name)")
                 .scrollContentBackground(.hidden)
                 .onAppear {
                     checkSugar()
                 }
                 .background(highSugar ? (animateColor ? .red.opacity(0.8) : .white.opacity(0.8)) : .blue.opacity(0.1))
                 }
                 ForEach(0..<getNumber()) { index in
                     Text(getEmoji(on: fruit.name))
                         .offset(x: Double.random(in: -200..<200), y: isAnimated ? 450 : -900)
                         .font(isAnimated ? .custom("San Francisco", size: 3.6) : .custom("San Francisco", size: 72.0))
                 }
         }.onAppear {
             withAnimation(
                 .easeOut(duration: 4)
                 .repeatForever(autoreverses: false)
             ) {
                 checkAmount()
             }
         }
     }
 }

func getEmoji(on name: String) -> String {
    let fruitEmoji: String
    switch name {
    case "Banana":
        fruitEmoji = "🍌"
    case "Grape":
        fruitEmoji = "🍇"
    case "Kiwi":
        fruitEmoji = "🥝"
    case "Pineapple":
        fruitEmoji = "🍍"
    case "Cherry":
        fruitEmoji = "🍒"
    case "Blueberry":
        fruitEmoji = "🫐"
    case "Lemon":
        fruitEmoji = "🍋"
    case "Orange":
        fruitEmoji = "🍊"
    case "Apple":
        fruitEmoji = "🍎"
    case "Mango":
        fruitEmoji = "🥭"
    case "Watermelon":
        fruitEmoji = "🍉"
    case "Avocado":
        fruitEmoji = "🥑"
    case "GreenApple":
        fruitEmoji = "🍏"
    case "Pear":
        fruitEmoji = "🍐"
    case "Strawberry":
        fruitEmoji = "🍓"
    case "Tomato":
        fruitEmoji = "🍅"
    default:
        fruitEmoji = "💯"
    }
    return fruitEmoji
}
 
 
 struct DetailPage_Previews: PreviewProvider {
     static var previews: some View {
         DetailPage(fruit).environment(\.managedObjectContext, DataModel.myShared.container.viewContext)
     }
 }
 
