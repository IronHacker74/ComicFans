//
//  BrowseFactory.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import Foundation

class BrowseFactory {
    func makeCoordinator(browseType: BrowseType) -> BrowseCoordinator {
        let request = BrowseRequest(browseType: browseType)
        let coordinator = BrowseCoordinator(request: request)
        return coordinator
    }
    
    func makeMediatingController(delegate: BrowseDelegate, screenTitle: String) -> BrowseMediatingController {
        return BrowseMediatingController(delegate: delegate, screenTitle: screenTitle)
    }
}
