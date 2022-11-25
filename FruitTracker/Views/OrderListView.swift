import SwiftUI

struct OrderListView: View {
    var orderText: String
    init(_ orderText: String) {
        self.orderText = orderText
    }
    
    @StateObject var viewModel = FruitViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.Fruits) {
                    fruit in
                    NavigationLink {
                        DetailPage(fruit)
                    }
                    label: {
                        Text(fruit.name)
                    }
                }
            }
            .task {
                await viewModel.loadOrderFruits(orderName: orderText)
            }
            .navigationTitle("Order: \(orderText)")
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(orderText).environmentObject(FruitViewModel())
    }
}
