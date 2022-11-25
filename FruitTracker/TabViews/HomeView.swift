import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack() {
            Text("Welcome to").font(.title3).foregroundColor(.gray)
            Text("Fruit Tracker\n").font(.largeTitle).foregroundColor(.orange)
            Image("home-image").clipShape(Circle()).shadow(color: .orange, radius: 30)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
