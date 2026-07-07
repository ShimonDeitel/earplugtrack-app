import Foundation

struct Entry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date
    var flag: Bool
    var rating: Int
    var note: String
}
