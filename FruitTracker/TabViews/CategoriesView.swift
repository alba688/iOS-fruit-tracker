import SwiftUI

struct CategoriesView: View {
    
    @StateObject var viewModel = FruitViewModel()

    @State private var showFamilies = false
    @State private var showOrders = false
    @State private var showGenus = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationView {
            List {
                DisclosureGroup("Family Names", isExpanded: $showFamilies) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.familyNames, id: \.self) {
                                Text($0)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 140, height: 50).foregroundColor(.white)
                                    .background(Rectangle().fill(.blue.gradient)).cornerRadius(10)
                            }
                        }
                    }
                }
                DisclosureGroup("Order Names", isExpanded: $showOrders) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.ordersNames, id: \.self) {
                                Text($0)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 140, height: 50).foregroundColor(.white)
                                    .background(Rectangle().fill(.blue.gradient)).cornerRadius(10)
                            }
                        }
                    }
                }
                DisclosureGroup("Genus Names", isExpanded: $showGenus) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.genusNames, id: \.self) {
                                Text($0)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 140, height: 50).foregroundColor(.white)
                                    .background(Rectangle().fill(.blue.gradient)).cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Fruit Categories")
            .onAppear() {
                Task {
                    await viewModel.loadFruits()
                }
            }
        }
    }
}


struct FruitGroupsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView().environmentObject(FruitViewModel())
    }
}
