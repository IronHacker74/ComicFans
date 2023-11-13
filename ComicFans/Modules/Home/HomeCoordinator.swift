//
//  HomeCoordinator.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import UIKit

struct HomeComicFansCategory {
    let title: BrowseType
    let image: UIImage?
}

final class HomeCoordinator: HomeDelegate {
    private let request: CurrentEventRequest
    private let limit: Int = 20
    private let navigator: UINavigationController?
    
    init(request: CurrentEventRequest, navigator: UINavigationController?) {
        self.request = request
        self.navigator = navigator
    }
    
    func homeMediatingControllerViewDidLoad(_ vc: HomeDisplayable, offset: Int) {
        self.request.getCurrentEvents(limit: self.limit, offset: offset, completion: {events, attribution, error in
            guard let events else {
                //TODO: do something with error
                return
            }
            DispatchQueue.main.async {
                vc.updateEvents(events)
                vc.updateAttributionText(attribution)
            }
        })
        let categories: [BrowseType] = [.characters, .comics, .creators, .events, .series, .stories]
        vc.updateCategories(categories)
    }
    
    func homeMediatingControllerCategoryCellTapped(browseType: BrowseType) {
        let factory = BrowseFactory()
        let coordinator = factory.makeCoordinator(browseType: browseType, navigator: self.navigator)
        let controller = factory.makeMediatingController(delegate: coordinator, screenTitle: browseType.rawValue.firstUppercased)
        self.navigator?.pushViewController(controller, animated: true)
    }
    
    func homeMediatingControllerEventTapped(event: DataSet, attribution: String?) {
        let factory = DetailsFactory()
        let coordinator = factory.makeCoordinator(dataSet: event, attribution: attribution)
        let controller = factory.makeMediatingController(delegate: coordinator)
        self.navigator?.pushViewController(controller, animated: true)
    }
}
