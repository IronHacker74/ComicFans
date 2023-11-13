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
    
    func getCurrentEvents(limit: Int, offset: Int, completion: @escaping ([DataSet]?, String?, Error?) -> (Void)) {
        let parameters: [DownloadParameterType : String] = [
            .orderBy : "-startDate",
            .limit : "\(limit)",
            .offset : "\(offset)"
        ]
        self.downloader.getRequest(endPoint: "events", parameters: parameters, completion: { data,error in
            guard let data else {
                completion(nil, nil, error)
                return
            }
            do {
                let eventData = try JSONDecoder().decode(APIData.self, from: data)
                completion(eventData.data.results, eventData.attributionText,  nil)
            } catch {
                // TODO: Add a specific error type here
                completion(nil, nil, nil)
            }
        })
    }
}


