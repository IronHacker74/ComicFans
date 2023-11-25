//
//  BrowseRequest.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import Foundation

final class BrowseRequest {
    private let downloader: Downloader
    private let browseType: BrowseType
    
    init(downloader: Downloader = Downloader(), browseType: BrowseType) {
        self.downloader = downloader
        self.browseType = browseType
    }
    
    func getBrowse(search: String = "", orderBy: OrderByType, limit: Int, offset: Int, completion: @escaping ([DataSet]?, String?, Error?) -> (Void)) {
        var parameters: [DownloadParameterType : String] = [
//            .orderBy : orderBy.rawValue,
            .limit : "\(limit)",
            .offset : "\(offset)"
        ]
        if !search.isEmpty {
            var searchParameter: DownloadParameterType = .nameStartsWith
            switch browseType {
            case .characters, .creators, .events:
                searchParameter = .nameStartsWith
            case .comics, .series:
                searchParameter = .titleStartsWith
            case .stories:
                searchParameter = .events
            case .none:
                return
            }
            parameters[searchParameter] = search
        }
        self.downloader.getRequest(endPoint: self.browseType.rawValue, parameters: parameters, completion: { data,error in
            guard let data else {
                completion(nil, nil, error)
                return
            }
            do {
                let results = try JSONDecoder().decode(APIData.self, from: data)
                completion(results.data.results, results.attributionText, nil)
            } catch {
                completion(nil, nil, error)
            }
        })
        
    }
}

