import SwiftUI

struct FruitTrackerView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("My exam!")
        }
        .padding()
    }
}

struct FruitTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        FruitTrackerView()
    }
}
