import Foundation

//struct HomeFilm: Decodable {
//    let docs: [HomePopularFilm]
//}
//
//struct HomePopularFilm: Decodable, Hashable {
//    let id: Int
//    let rating: Rating
//    let description: String
//    let genres: [HomeGenre]
//    let enName: String
//}
//
//struct HomeGenre: Decodable, Hashable {
//    let name: String
//}
//
//struct Rating: Decodable, Hashable {
//    let kp: Double
//}



//// MARK: - Welcome
//struct HomeFilm: Decodable {
//    let docs: [HomePopularFilm]
//}
//
//// MARK: - Doc
//struct HomePopularFilm: Decodable, Hashable {
//    let rating: Rating?
//    let backdrop: Backdrop?
//    let movieLength, id: Int?
//    let name, description: String?
//    let year: Int?
//    let poster: Backdrop?
//    let genres: [Country]?
//    let enName: String
//    let names: [Name]?
//    let logo: Logo?
//}
//
//struct Backdrop: Decodable, Hashable {
//    let url, previewURL: String?
//}
//
//struct Country: Decodable, Hashable {
//    let name: String?
//}
//
//struct Logo: Decodable, Hashable {
//    let url: String?
//}
//
//struct Name: Decodable, Hashable {
//    let name: String?
//}
//
//struct Rating: Decodable, Hashable {
//    let kp: Double
//}


import Foundation

// MARK: - Welcome
struct HomeFilm: Decodable {
    let docs: [HomePopularFilm]
}

struct HomePopularFilm: Decodable, Hashable {
    let rating: Rating
//    let backdrop: Backdrop?
//    let movieLength: Int?
    let id: Int?
//    let type: TypeEnum?
    let name, description: String
//    let year: Int?
    let poster: Backdrop
    let genres: [Country]?
    let enName: String?
//    let names: [Name]?
//    let shortDescription: String?
//    let logo: Logo
//    let seriesLength: Int?
//    let releaseYears: [ReleaseYear]?
}

struct Backdrop: Decodable, Hashable {
    let url: String
}

struct Country: Decodable, Hashable {
    let name: String?
}

struct Logo: Decodable, Hashable {
    let url: String
}

struct Name: Decodable, Hashable {
    let name, language: String?
    let type: String?
}

struct Rating: Decodable, Hashable {
    let kp: Double
}

struct ReleaseYear: Decodable, Hashable {
    let start, end: Int?
}

enum TypeEnum: String, Decodable, Hashable {
    case cartoon
    case movie
    case tvSeries
}
