//
//  CurrentEventRequest.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import Foundation

final class CurrentEventRequest {
    let downloader: Downloader
    
    init(downloader: Downloader = Downloader()) {
        self.downloader = downloader
    }
    
    func getCurrentEvents(limit: Int, offset: Int, completion: @escaping ([Event]?, Error?) -> (Void)) {
        let parameters: [DownloadParameterType : String] = [
            .orderBy : "-startDate",
            .limit : "\(limit)",
            .offset : "\(offset)"
        ]
        self.downloader.getRequest(endPoint: "events", parameters: parameters, completion: { data,error in
            guard let data else {
                completion(nil, error)
                return
            }
            do {
                let eventData = try JSONDecoder().decode(EventData.self, from: data)
                completion(eventData.data.results, nil)
            } catch {
                // TODO: Add a specific error type here
                completion(nil, nil)
            }
        })
    }
}


struct EventData: Decodable {
    let data: ResultsData
    let attributionText: String
    struct ResultsData: Decodable {
        let results: [Event]?
    }
}


