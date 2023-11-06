//
//  Event.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import Foundation

struct Event: Decodable {
    let title: String
    let description: String
    let thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case thumbnail = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
    }
    
    init(title: String, description: String, thumbnail: Thumbnail){
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
}
