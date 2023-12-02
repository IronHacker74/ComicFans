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
    private var downloadComplete: Bool = false
    private var isDownloading: Bool = false
    private let limit: Int = 20
    private let navigator: UINavigationController?
    
    init(request: CurrentEventRequest, navigator: UINavigationController?) {
        self.request = request
        self.navigator = navigator
    }
    
    func homeMediatingControllerViewDidLoad(_ vc: HomeDisplayable) {
        guard !self.isDownloading else { return }
        self.isDownloading = true
        vc.beginProcessing()
        self.request.getCurrentEvents(limit: self.limit, offset: 0, completion: {events, attribution, error in
            DispatchQueue.main.async {
                self.isDownloading = false
                vc.finishProcessing()
                guard let events else {
                    vc.presentErrorAlert()
                    return
                }
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
        let coordinator = factory.makeCoordinator(dataSet: event, attribution: attribution, detailsPath: nil, navigator: self.navigator)
        let controller = factory.makeMediatingController(delegate: coordinator)
        self.navigator?.pushViewController(controller, animated: true)
    }
    
    func homeMediatingControllerLoadMoreEvents(_ vc: HomeDisplayable, offset: Int) {
        guard !self.downloadComplete else { return }
        guard !self.isDownloading else { return }
        self.isDownloading = true
        vc.beginProcessing()
        self.request.getCurrentEvents(limit: self.limit, offset: offset, completion: { events, _, error in
            DispatchQueue.main.async {
                self.isDownloading = false
                vc.finishProcessing()
                guard let events else {
                    vc.presentErrorAlert()
                    return
                }
                if events.count < self.limit {
                    self.downloadComplete = true
                }
                vc.updateEvents(events)
            }
        })
    }
    
    func homeMediatingControllerDidTouchMarvelTrivia() {
        let factory = TriviaFactory()
        let coordinator = factory.makeCoordinator()
        let controller = factory.makeMediatingController(delegate: coordinator)
        self.navigator?.pushViewController(controller, animated: true)
    }
}
