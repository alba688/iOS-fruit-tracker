import SwiftUI

struct DetailPage: View {
    var fruit: Fruit
    init(_ fruit: Fruit) {
        self.fruit = fruit
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(fruit.name).font(.title2)
                Spacer()
                Text("id #: \(fruit.id)")
            }
            Text("\(fruit.family) / \(fruit.genus)").font(.title3).foregroundColor(.gray)
            Text("Carbohydrates: \(fruit.nutritions.carbohydrates, specifier: "%.2f")g")
            Text("Protein: \(fruit.nutritions.protein, specifier: "%.2f")g")
            Text("Fatt: \(fruit.nutritions.fat, specifier: "%.2f")g")
            Text("Sugar: \(fruit.nutritions.sugar, specifier: "%.2f")g")
            Button("+ Eat this fruit") {
                //AddFruitView(fruit)
            }.buttonStyle(.borderedProminent)
            Spacer()
        }.padding(10)
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(fruit)
    }
}
