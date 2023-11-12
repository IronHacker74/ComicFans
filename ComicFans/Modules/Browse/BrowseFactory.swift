//
//  BrowseFactory.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import Foundation
import UIKit

class BrowseFactory {
    func makeCoordinator(browseType: BrowseType, navigator: UINavigationController?) -> BrowseCoordinator {
        let request = BrowseRequest(browseType: browseType)
        let coordinator = BrowseCoordinator(request: request, navigator: navigator)
        return coordinator
    }
    
    func makeMediatingController(delegate: BrowseDelegate, screenTitle: String) -> BrowseMediatingController {
        return BrowseMediatingController(delegate: delegate, screenTitle: screenTitle)
    }
}
