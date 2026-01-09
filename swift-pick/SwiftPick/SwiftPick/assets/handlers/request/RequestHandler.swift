import Foundation

@MainActor
@Observable
public class RequestHandler {
    public var data: [String: Any] = [String: Any]()
    private let url: String = "https://swiftpickapi.vercel.app/api"
    
    public func fetchAll(for target: String) async {
        await self.handle(for: "\(self.url)/\(target)", target)
    }//fetchRecords

    private func handle(for url: String, _ target: String) async {
        // Check url validity.
        if let url = URL(string: url) {
            do {
                // Process URL as a request.
                let request = URLRequest(url: url)
                
                // Fetch the data and the response headers.
                let (data, _) = try await URLSession.shared.data(for: request)
                
                var decodedData: Any?
                
                if target == "categories" { // Decode JSON string based on Categories Struct.
                    decodedData = try JSONDecoder().decode(Categories.self, from: data)
                } else if target == "collections" { // Decode JSON string based on Collections Struct.
                    decodedData = try JSONDecoder().decode(Collections.self, from: data)
                } else if target == "podcasts" { // Decode JSON string based on Podcasts Struct.
                    decodedData = try JSONDecoder().decode(Podcasts.self, from: data)
                } else if target == "products" { // Decode JSON string based on Products Struct.
                    decodedData = try JSONDecoder().decode(Products.self, from: data)
                } else if target == "stores" { // Decode JSON string based on Stores Struct.
                    decodedData = try JSONDecoder().decode(Stores.self, from: data)
                }//if
                
                self.data[target] = decodedData
            } catch {
                print("Error Caught - Error processing initial API request.")
            }//do
        }//if
    }//handle
}//RequestHandler
