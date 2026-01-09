import Foundation

public class Podcast: Identifiable, Codable {
    public let episodeId: Int
    public let guestName: String
    public let thumbnail: String
    public let link: String
    public let unlocksAt: Int
    
    public var id: UUID {
        return UUID()
    }//id
}//Podcast

public class Podcasts: Codable {
    public var data: [Podcast]
}//Podcasts
