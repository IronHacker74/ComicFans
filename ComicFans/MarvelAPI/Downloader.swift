//
//  Downloader.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import Foundation

enum DownloadParameterType: String {
    case apiKey = "apikey"
    case hashedAPI = "hash"
    case timestamp = "ts"
    case orderBy = "orderBy"
    case limit = "limit"
    case offset = "offset"
    case name = "name"
    case nameStartsWith = "nameStartsWith"
    case titleStartsWith = "titleStartsWith"
    case comics = "comics"
    case characters = "characters"
    case creators = "creators"
    case events = "events"
    case series = "series"
}

enum OrderByType: String {
    case startDate = "startDate"
    case name = "name"
    case modified = "modified"
    case reverseStartDate = "-startDate"
    case reverseName = "-name"
    case reverseModified = "-modified"
}

final class Downloader {
    fileprivate let baseURL = "http://gateway.marvel.com/v1/public/"
    private var timestamp: String {
        return NSDate().timeIntervalSince1970.description
    }
    private let apiKeys = APIKeys()
    
    func getRequest(endPoint: String, parameters: [DownloadParameterType: String], needBaseURL: Bool = true, completion: @escaping (Data?, Error?) -> Void) {
        let urlPath = needBaseURL ? self.baseURL + endPoint : endPoint
        
        let localTimeStamp = self.timestamp
        let hashedAPI = (localTimeStamp+self.apiKeys.privateKey+self.apiKeys.publicKey).MD5
        var localParameters: [DownloadParameterType: String] = parameters
        localParameters[.timestamp] = localTimeStamp
        localParameters[.apiKey] = self.apiKeys.publicKey
        localParameters[.hashedAPI] = hashedAPI
        
        self.request(url: urlPath, parameters: localParameters, completion: completion)
    }
    
    private func request(url: String, parameters: [DownloadParameterType: String], completion: @escaping (Data?, Error?) -> Void) {
        guard var components = URLComponents(string: url) else {
            completion(nil, nil)
            return
        }
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key.rawValue, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%20")
        let request = URLRequest(url: components.url!)
        
        print("attempting request from: \(request.url?.absoluteString ?? "")")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,                              // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                error == nil                                  // was there no error
            else {
                print(error?.localizedDescription as Any)
                completion(nil, error)
                return
            }
            print("Successful data request from: \(request.url?.absoluteString ?? "")")
            completion(data, nil)
        }
        task.resume()
    }
}
