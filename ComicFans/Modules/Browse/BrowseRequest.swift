//
//  BrowseRequest.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import Foundation

final class BrowseRequest {
    let downloader: Downloader
    let browseType: BrowseType
    
    init(downloader: Downloader = Downloader(), browseType: BrowseType) {
        self.downloader = downloader
        self.browseType = browseType
    }
    
    func getBrowse(orderBy: OrderByType, limit: Int, offset: Int, completion: @escaping ([DataSet]?, String?, Error?) -> (Void)) {
        let parameters: [DownloadParameterType : String] = [
//            .orderBy : orderBy.rawValue,
            .limit : "\(limit)",
            .offset : "\(offset)"
        ]
        self.downloader.getRequest(endPoint: self.browseType.rawValue, parameters: parameters, completion: { data,error in
            guard let data else {
                completion(nil, nil, error)
                return
            }
            do {
                let results = try JSONDecoder().decode(APIData.self, from: data)
                completion(results.data.results, results.attributionText, nil)
            } catch {
                // TODO: Return an error type
                completion(nil, nil, nil)
            }
        })
        
    }
}

