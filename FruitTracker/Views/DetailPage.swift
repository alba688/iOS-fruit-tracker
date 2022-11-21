import SwiftUI

struct DetailPage: View {
    var fruit: Fruit
    init(_ fruit: Fruit) {
        self.fruit = fruit
    }
    @State var animateFruit = false
    
    @State var highSugar = false
    
    private func checkSugar() {
        if (fruit.nutritions.sugar >= 10.0) {
            highSugar = true
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            VStack (alignment: .leading) {
                HStack {
                    Text(fruit.name).font(.title2)
                    Spacer()
                    Text("id #: \(fruit.id)")
                }
                Text("\(fruit.order) > \(fruit.family) > \(fruit.genus)").font(.title3).foregroundColor(.gray)
                Text("Carbohydrates: \(fruit.nutritions.carbohydrates, specifier: "%.2f")g")
                Text("Protein: \(fruit.nutritions.protein, specifier: "%.2f")g")
                Text("Fat: \(fruit.nutritions.fat, specifier: "%.2f")g")
                Text("Sugar: \(fruit.nutritions.sugar, specifier: "%.2f")g")
                Button("+ Eat this fruit") {
                    //AddFruitView(fruit)
                }.buttonStyle(.borderedProminent).padding(.bottom)
                Button("animate") {
                    self.animateFruit.toggle()
                    withAnimation(.easeOut(duration: 4)) {
                        animateFruit = true
                    }
                }.buttonStyle(.borderedProminent)
            }
            .padding(10)
            .background(highSugar ? .red.opacity(0.8) : .blue.opacity(0.2))
            .onAppear{
                checkSugar()
            }
            
            HStack {
                Text("🍌").font(.title)
                    .frame(width:50, height:50, alignment: .center)
                    .position(x:50, y: animateFruit ? 800 : -40)
                Text("🍌").font(.title)
                    .frame(width:50, height:50, alignment: .center)
                    .position(x:70, y: animateFruit ? 800 : -60)
                Text("🍌").font(.title)
                    .frame(width:50, height:50, alignment: .center)
                    .position(x:90, y: animateFruit ? 800 : -50)
            }.onAppear {
                withAnimation(.easeOut(duration: 3)) {
                    animateFruit = true
                }
            }
            
        }
    }
}


struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(fruit)
    }
}
