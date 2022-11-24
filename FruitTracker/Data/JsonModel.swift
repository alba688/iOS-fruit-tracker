import Foundation

// create a class of data from json that is observable within application
final class JsonModel: ObservableObject {
    
    func fetchFruits() async throws -> [Fruit] {
        let urlString = "https://www.fruityvice.com/api/fruit/all"
        guard let url = URL(string: urlString) else { throw NSError() } 
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Fruit].self, from: data)
    }
}
