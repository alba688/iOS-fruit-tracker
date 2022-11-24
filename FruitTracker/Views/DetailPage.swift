import SwiftUI

struct DetailPage: View {
    var fruit: Fruit
    init(_ fruit: Fruit) {
        self.fruit = fruit
     }
 
     //@State var animateFruit = false
     @State var highSugar = false
     @State var animateColor = false
 
     private func checkSugar() {
         if (fruit.nutritions.sugar >= 10.0) {
             highSugar = true
             withAnimation(.easeInOut(duration: 2).repeatForever()){
                 animateColor = true
             }
         }
     }
 
     var body: some View {
         ZStack {
             VStack (alignment: .leading) {
             List {
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
                 
                     Button {
                     //EatFruitView
                     } label: {
                         Text("+ Eat Fruit")
                     }.buttonStyle(.borderedProminent).foregroundColor(.white)
                 }
             }
             .navigationTitle("\(fruit.name) (Id: \(fruit.id))")
             .scrollContentBackground(.hidden)
             .onAppear {
                 checkSugar()
             }
             .background(highSugar ? (animateColor ? .red.opacity(0.8) : .white.opacity(0.8)) : .blue.opacity(0.1))
             }
         }
     }
 }
 
 
 struct DetailPage_Previews: PreviewProvider {
     static var previews: some View {
         DetailPage(fruit)
     }
 }
 
