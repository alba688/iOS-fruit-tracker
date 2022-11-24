import SwiftUI

struct CategoriesView: View {
    
    @EnvironmentObject var jsonData: JsonModel
    
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
                            ForEach(jsonData.familyNames, id: \.self) {
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
                            ForEach(jsonData.ordersNames, id: \.self) {
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
                            ForEach(jsonData.genusNames, id: \.self) {
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
                    await jsonData.loadFruits()
                }
            }
        }
    }
}


struct FruitGroupsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView().environmentObject(JsonModel())
    }
}
