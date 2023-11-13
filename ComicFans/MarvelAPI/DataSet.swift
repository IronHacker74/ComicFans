//
//  DataSetProtocol.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/10/23.
//

import Foundation
import UIKit

struct APIData: Decodable {
    let data: ResultsData
    let attributionText: String
    struct ResultsData: Decodable {
        let results: [DataSet]?
    }
}

struct DataSet: Decodable {
    var id: Int?
    var title: String?
    var name: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var description: String?
    var thumbnail: Thumbnail?
    var image: UIImage?
    var characters: AdditionalItems?
    var creators: AdditionalItems?
    var comics: AdditionalItems?
    var series: AdditionalItems?
    var stories: AdditionalItems?
    var events: AdditionalItems?
    var urls: [URLItem]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case name
        case firstName
        case middleName
        case lastName
        case description
        case thumbnail = "thumbnail"
        case characters
        case creators
        case comics
        case series
        case stories
        case events
        case urls
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.firstName = try? container.decode(String.self, forKey: .firstName)
        self.middleName = try? container.decode(String.self, forKey: .middleName)
        self.lastName = try? container.decode(String.self, forKey: .lastName)
        self.title = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.thumbnail = try? container.decode(Thumbnail.self, forKey: .thumbnail)
        self.characters = try? container.decode(AdditionalItems.self, forKey: .characters)
        self.creators = try? container.decode(AdditionalItems.self, forKey: .creators)
        self.comics = try? container.decode(AdditionalItems.self, forKey: .comics)
        self.series = try? container.decode(AdditionalItems.self, forKey: .series)
        self.stories = try? container.decode(AdditionalItems.self, forKey: .stories)
        self.events = try? container.decode(AdditionalItems.self, forKey: .events)
        self.urls = try? container.decode([URLItem].self, forKey: .urls)
    }
    
    init(id: Int?, name: String?, title: String?, description: String?, thumbnail: Thumbnail){
        self.id = id
        self.name = name
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
    
    func getTitle() -> String? {
        if let title { return title }
        if let name { return name }
        return fullName()
    }
    
    func fullName() -> String? {
        guard let firstName, let middleName, let lastName else { return "" }
        return firstName + " " + middleName + " " + lastName
    }
}

struct AdditionalItems: Decodable {
    let items: [Item]
    var category: String?
    
    struct Item: Decodable {
        let resourceURI: String?
        let name: String?
        let type: String?
        init(resourceURI: String?, name: String?, type: String?) {
            self.resourceURI = resourceURI
            self.name = name
            self.type = type
        }
    }
}

struct URLItem: Decodable {
    let type: String
    let url: String
}

