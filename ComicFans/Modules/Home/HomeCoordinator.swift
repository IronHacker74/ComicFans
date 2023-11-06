//
//  HomeCoordinator.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import UIKit

enum SubjectCategory: String {
    case comics = "Comics"
    case characters = "Characters"
    case creators = "Creators"
    case events = "Events"
    case series = "Series"
    case stories = "Stories"
}

struct HomeComicFansCategory {
    let title: SubjectCategory
    let image: UIImage?
}

final class HomeCoordinator: HomeDelegate {
    private let request: CurrentEventRequest
    private let limit: Int = 20
    
    init(request: CurrentEventRequest) {
        self.request = request
    }
    
    func homeMediatingControllerViewDidLoad(_ vc: HomeDisplayable, offset: Int) {
        self.request.getCurrentEvents(limit: self.limit, offset: offset, completion: {events, error in
            guard let events else {
                //TODO: do something with error
                return
            }
            DispatchQueue.main.async {
                vc.updateEvents(events)
            }
        })
        let categories: [HomeComicFansCategory] = [
            HomeComicFansCategory(title: .comics, image: nil),
            HomeComicFansCategory(title: .characters, image: nil),
            HomeComicFansCategory(title: .series, image: nil),
            HomeComicFansCategory(title: .stories, image: nil),
            HomeComicFansCategory(title: .events, image: nil),
            HomeComicFansCategory(title: .creators, image: nil)

        ]
        vc.updateCategories(categories)
    }
}
