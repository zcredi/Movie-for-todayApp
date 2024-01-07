import Foundation

class URLRequestGenerator {
    private let baseURL = "https://api.kinopoisk.dev/v1.4/"
    private let apiKey = "CA0Y6V3-4JPMCKW-PTSQ135-YPKXT4X"
    
    // CA0Y6V3-4JPMCKW-PTSQ135-YPKXT4X
    // 1TMH0NP-45VMCVB-J4Y4RF6-TZQ7ZW7
    // YGNWPD2-KY7MSX4-KTC4RS6-H8W2C2M
    // RH9700B-VAJ47JC-P92YAMQ-5WRVNRQ
    // BR9GX9R-2TD4AQX-H67HE11-CSGFVP4
    // 4M3ZC0R-XYV44S1-QE7HWZA-ASPTETW
    // MEY4BQK-S3G4X7A-QWH2AEP-MKCHDYX
    
    func request(endpoint: String, genre: String = "", queryItems: [URLQueryItem] = []) -> URLRequest? {
        guard let baseURL = URL(string: baseURL) else { return nil }
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: true)
        
        var allQueryItems = queryItems
        if !genre.isEmpty {
            allQueryItems.append(URLQueryItem(name: "genres.name", value: genre))
        }
        
        components?.queryItems = allQueryItems
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.httpMethod = "GET"
        print(request.allHTTPHeaderFields)
        print(request)
        return request
    }
}
