import Foundation

// data class is observable within application
final class JsonModel: ObservableObject {
    
    func fetchFruits() async throws -> [Fruit] {
        let urlString = "https://www.fruityvice.com/api/fruit/all"
        guard let url = URL(string: urlString) else { throw NSError() } 
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Fruit].self, from: data)
    }
    
    func fetchFamily(familyName: String) async throws -> [Fruit] {
        let urlString = "https://www.fruityvice.com/api/fruit/family/" + familyName
        guard let url = URL(string: urlString) else { throw NSError() }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Fruit].self, from: data)
    }
    
    func fetchOrder(orderName: String) async throws -> [Fruit] {
        let urlString = "https://www.fruityvice.com/api/fruit/order/" + orderName
        guard let url = URL(string: urlString) else { throw NSError() }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Fruit].self, from: data)
    }
    
    func fetchGenus(genusName: String) async throws -> [Fruit] {
        let urlString = "https://www.fruityvice.com/api/fruit/genus/" + genusName
        guard let url = URL(string: urlString) else { throw NSError() }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Fruit].self, from: data)
    }
}
