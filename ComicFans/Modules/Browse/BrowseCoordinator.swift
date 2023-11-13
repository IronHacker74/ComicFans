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
    
    init(request: BrowseRequest, navigator: UINavigationController?) {
        self.request = request
        self.navigator = navigator
    }
    
    func browseViewDidLoad(_ vc: BrowseDisplayable, offset: Int) {
        vc.setupCollectionview()
        self.request.getBrowse(orderBy: .name, limit: 20, offset: offset, completion: { results, attribution, error in
            guard let results, error == nil else {
                // TODO: show error
                return
            }
            DispatchQueue.main.async {
                vc.updateBrowseCollectionView(browseArray: results)
                vc.updateAttributionText(attribution)
            }
        })
    }
    
    func browseCollectionViewCellTapped(dataSet: DataSet, attribution: String?) {
        let factory = DetailsFactory()
        let coordinator = factory.makeCoordinator(dataSet: dataSet, attribution: attribution)
        let controller = factory.makeMediatingController(delegate: coordinator)
        self.navigator?.pushViewController(controller, animated: true)
    }
}
