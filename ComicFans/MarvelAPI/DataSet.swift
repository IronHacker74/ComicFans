//
//  DataSetProtocol.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/10/23.
//

import Foundation

protocol DataSetProtocol: Decodable {
    var title: String? { get set }
    var description: String? { get set }
    var thumbnail: Thumbnail? { get set }
    func getTitle() -> String?
}

class DataSet: DataSetProtocol {
    var id: String?
    var title: String?
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case name
        case description
        case thumbnail = "thumbnail"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.title = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.thumbnail = try? container.decode(Thumbnail.self, forKey: .thumbnail)
    }
    
    init(id: String?, name: String?, title: String?, description: String?, thumbnail: Thumbnail){
        self.id = id
        self.name = name
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
    
    func getTitle() -> String? {
        return self.title ?? self.name
    }
}
