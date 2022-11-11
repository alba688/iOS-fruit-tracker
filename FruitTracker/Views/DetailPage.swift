import SwiftUI

struct DetailPage: View {
    var fruit: Fruit
    init(_ fruit: Fruit) {
        self.fruit = fruit
    }
    
    var body: some View {
        Text(fruit.name)
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(fruit)
    }
}
