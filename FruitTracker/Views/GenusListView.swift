import SwiftUI

struct GenusListView: View {
    var genusText: String
    init(_ genusText: String) {
        self.genusText = genusText
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
                await viewModel.loadGenusFruits(genusName: genusText)
            }
            .navigationTitle("Genus: \(genusText)")
        }
    }
}

struct GenusListView_Previews: PreviewProvider {
    static var previews: some View {
        GenusListView(genusText).environmentObject(FruitViewModel())
    }
}
