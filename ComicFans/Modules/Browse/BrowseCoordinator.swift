//
//  BrowseCoordinator.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import UIKit

class BrowseCoordinator: BrowseDelegate {
    let request: BrowseRequest
    let navigator: UINavigationController?
    private let limit = 20
    private var downloadComplete: Bool = false
    private var isDownloading: Bool = false
    
    init(request: BrowseRequest, navigator: UINavigationController?) {
        self.request = request
        self.navigator = navigator
    }
    
    func browseViewDidLoad(_ vc: BrowseDisplayable) {
        vc.setupCollectionview()
        guard isDownloading == false else { return }
        vc.beginProcessing()
        self.isDownloading = true
        self.request.getBrowse(orderBy: .name, limit: self.limit, offset: 0, completion: { results, attribution, error in
            self.isDownloading = false
            guard let results, error == nil else {
                // TODO: show error
                return
            }
            DispatchQueue.main.async {
                vc.finishProcessing()
                vc.appendToBrowseCollectionViewData(results)
                vc.updateAttributionText(attribution)
            }
        })
    }
    
    func browseCollectionViewCellTapped(dataSet: DataSet, attribution: String?) {
        let factory = DetailsFactory()
        let coordinator = factory.makeCoordinator(dataSet: dataSet, attribution: attribution, detailsPath: nil, navigator: self.navigator)
        let controller = factory.makeMediatingController(delegate: coordinator)
        self.navigator?.pushViewController(controller, animated: true)
    }
    
    func browseDownloadMoreData(_ vc: BrowseDisplayable, searchText: String?, offset: Int) {
        if offset == 0 {
            self.downloadComplete = false
        }
        guard downloadComplete == false else { return }
        guard isDownloading == false else { return }
        vc.beginProcessing()
        self.isDownloading = true
        self.request.getBrowse(search: searchText ?? "", orderBy: .name, limit: self.limit, offset: offset, completion: { results, attribution, error in
            self.isDownloading = false
            guard let results, error == nil else {
                // TODO: show error
                return
            }
            DispatchQueue.main.async {
                if results.count < self.limit {
                    self.downloadComplete = true
                }
                vc.finishProcessing()
                vc.appendToBrowseCollectionViewData(results)
            }
        })
    }
}
