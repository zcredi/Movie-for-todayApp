import Foundation

struct ImageModel: Codable {
    let docs: [PopularImage]
}

// MARK: - Doc
struct PopularImage: Codable, Hashable {
    let url: String
}
