
import SwiftUI


 struct FamilyListView: View {
     var familyText: String
     init(_ familyText: String) {
         self.familyText = familyText
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
                 await viewModel.loadFamilyFruits(familyName: familyText)
             }
             .navigationTitle("Family: \(familyText)")
         }
    }
 }
 
 
  struct FamilyListView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyListView(familyText)
            .environmentObject(FruitViewModel())
    }
 }

  
 
