import Foundation

class HomeViewModel {
    private let networkManager = NetworkManager()
    private let urlGenerator = URLRequestGenerator()
    var popularFilms = [HomePopularFilm]()
    var headerFilms = [Films]()
    
    public func fetchFilms(genre: String, completion: @escaping (Result<[HomePopularFilm], Error>) -> Void) {
        let headersRequest = urlGenerator.request(endpoint: "movie", genre: genre, queryItems: [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "notNullFields", value: "id"),
            URLQueryItem(name: "notNullFields", value: "enName"),
            URLQueryItem(name: "notNullFields", value: "rating.kp"),
            URLQueryItem(name: "notNullFields", value: "poster.url")
        ])
        
        networkManager.request(generator: headersRequest) { (result: Result<HomeFilm, Error>) in
            switch result {
            case .success(let success):
                let model = success.docs
                completion(.success(model))
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(.failure(failure))
            }
        }
    }
    
    public func fetchHeaderFilms(completion: @escaping (Result<[Films], Error>) -> Void) {
        let headersREquest = urlGenerator.request(endpoint: "list", queryItems: [
            URLQueryItem(name: "notNullFields", value: "cover.url"),
            URLQueryItem(name: "notNullFields", value: "cover.previewUrl"),
            URLQueryItem(name: "notNullFields", value: "name"),
            URLQueryItem(name: "notNullFields", value: "category"),
        ])
        
        networkManager.request(generator: headersREquest) { (result: Result<FilmCollection, Error>) in
            switch result {
            case .success(let success):
                let model = success.docs
                completion(.success(model))
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(.failure(failure))
            }
        }
    }
}
