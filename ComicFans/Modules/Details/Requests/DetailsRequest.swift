//
//  DetailsRequest.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/22/23.
//

import Foundation

final class DetailsRequest {
    private let downloader: Downloader
    
    init(downloader: Downloader) {
        self.downloader = downloader
    }
    
    func getDetails(urlpath: String, completion: @escaping (DataSet?, String?, Error?) -> (Void)) {
        self.downloader.getRequest(endPoint: urlpath, parameters: [:], needBaseURL: false, completion: { data, error in
            guard let data, error == nil else {
                completion(nil, nil, error)
                return
            }
            do {
                let results = try JSONDecoder().decode(APIData.self, from: data)
                completion(results.data.results?.first, results.attributionText, nil)
            } catch {
                // TODO: Return an error type
                completion(nil, nil, nil)
            }
        })
    }
}
