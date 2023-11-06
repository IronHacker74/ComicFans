//
//  Thumbnail.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import Foundation
import UIKit

struct Thumbnail: Decodable {
    private let path: String
    private let pathextension: String
    let fullPath: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case pathExtension = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.pathextension = try container.decode(String.self, forKey: .pathExtension)
        self.fullPath = self.path + "." + self.pathextension
    }
    
    init(path: String, pathextension: String, fullPath: String) {
        self.path = path
        self.pathextension = pathextension
        self.fullPath = fullPath
    }
}
