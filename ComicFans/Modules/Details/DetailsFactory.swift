//
//  DetailsFactory.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/11/23.
//

import UIKit

final class DetailsFactory {
    func makeCoordinator(dataSet: DataSet?, attribution: String?, detailsPath: String?, navigator: UINavigationController?) -> DetailsCoordinator {
        let detailsRequest = detailsPath == nil ? nil : DetailsRequest(downloader: Downloader())
        return DetailsCoordinator(dataSet: dataSet, attribution: attribution, detailsRequest: detailsRequest, detailsURLPath: detailsPath, navigator: navigator)
    }
    
    func makeMediatingController(delegate: DetailsCoordinator) -> DetailsMediatingController {
        return DetailsMediatingController(delegate: delegate)
    }
}
