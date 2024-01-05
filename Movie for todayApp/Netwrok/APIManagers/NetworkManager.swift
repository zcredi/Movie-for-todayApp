import Foundation

class NetworkManager {
    enum NetworkManagerError: Error {
        case requestNotDefined
        case resultIsEmpty
        case apiKeyLimitReached
    }

    private let jsonDecoder = JSONDecoder()

    func request<T: Decodable>(generator: URLRequest?, _ completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = generator else {
            DispatchQueue.main.async {
                completion(.failure(NetworkManagerError.requestNotDefined))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            let result: Result<T, Error>
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 403 {
                result = .failure(NetworkManagerError.apiKeyLimitReached)
            } else if let error {
                result = .failure(error)
            } else if let data {
                do {
                    let decodedObject = try self.jsonDecoder.decode(T.self, from: data)
                    result = .success(decodedObject)
                } catch let decodingError as DecodingError {
                    print(decodingError.localizedDescription)
                    result = .failure(decodingError)
                } catch {
                    result = .failure(error)
                }
            } else {
                result = .failure(NetworkManagerError.resultIsEmpty)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    }
}
