//
//  TriviaRequest.swift
//  ComicFans
//
//  Created by Andrew Masters on 12/1/23.
//

import Foundation

final class TriviaRequest {
    let downloader: Downloader
    
    init(downloader: Downloader = Downloader()) {
        self.downloader = downloader
    }
    
    func getComics(limit: Int, offset: Int, completion: @escaping ([DataSet]?, Int?, String?, Error?) -> (Void)) {
        let paramters: [DownloadParameterType : String] = [
            .orderBy : OrderByType.reverseModified.rawValue,
            .limit : "\(limit)",
            .offset : "\(offset)"
        ]
        self.downloader.getRequest(endPoint: BrowseType.comics.rawValue, parameters: paramters, completion: { data, error in
            guard let data else {
                completion(nil, nil, nil, error)
                return
            }
            do {
                let comicData = try JSONDecoder().decode(APIData.self, from: data)
                completion(comicData.data.results, comicData.data.total, comicData.attributionText, nil)
            } catch {
                completion(nil, nil, nil, error)
            }
        })
    }
    
    func getCharacters(limit: Int, offset: Int, completion: @escaping ([DataSet]?, Int?, String?, Error?) -> (Void)) {
        let paramters: [DownloadParameterType : String] = [
            .orderBy : OrderByType.reverseModified.rawValue,
            .limit : "\(limit)",
            .offset : "\(offset)"
        ]
        self.downloader.getRequest(endPoint: BrowseType.characters.rawValue, parameters: paramters, completion: { data, error in
            guard let data else {
                completion(nil, nil, nil, error)
                return
            }
            do {
                let comicData = try JSONDecoder().decode(APIData.self, from: data)
                completion(comicData.data.results, comicData.data.total, comicData.attributionText, nil)
            } catch {
                completion(nil, nil, nil, error)
            }
        })
    }
}
