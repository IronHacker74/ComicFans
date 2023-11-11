//
//  Character.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import Foundation

class Character: DataSet {
}

struct BrowseCharactersData: Decodable {
    let data: ResultsData
    let attributionText: String
    struct ResultsData: Decodable {
        let results: [Character]?
    }
}
