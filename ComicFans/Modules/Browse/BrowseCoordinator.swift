//
//  BrowseCoordinator.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import UIKit

class BrowseCoordinator: BrowseDelegate {
    let request: BrowseRequest
    
    init(request: BrowseRequest) {
        self.request = request
    }
    
    func browseViewDidLoad(_ vc: BrowseDisplayable, offset: Int) {
        vc.setupCollectionview()
        self.request.getBrowse(orderBy: .name, limit: 20, offset: offset, completion: { results, error in
            guard let results, error == nil else {
                // TODO: show error
                return
            }
            DispatchQueue.main.async {
                vc.updateBrowseCollectionView(browseArray: results)
            }
        })
    }
}
