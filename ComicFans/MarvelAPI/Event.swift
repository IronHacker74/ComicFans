//
//  Event.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import Foundation

class Event: DataSet {
}

struct CurrentEventData: Decodable {
    let data: ResultsData
    let attributionText: String
    struct ResultsData: Decodable {
        let results: [Event]?
    }
}
