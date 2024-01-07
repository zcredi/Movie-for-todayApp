import Foundation

struct FilmCollection: Decodable {
    let docs: [Films]
}

struct Films: Decodable, Hashable {
    let category: String?
    let name: String?
    let moviesCount: Int
    let cover: Cover
    let createdAt, updatedAt, id: String?
}

struct Cover: Decodable, Hashable {
    let url: String
}
