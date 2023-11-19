//
//  DetailsCoordinator.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/11/23.
//

import UIKit

final class DetailsCoordinator: DetailsDelegate {
    private let dataSet: DataSet
    private let attribution: String?
    
    init(dataSet: DataSet, attribution: String?) {
        self.dataSet = dataSet
        self.attribution = attribution
    }
    
    func detailsMediatingControllerViewDidLoad(_ vc: DetailsDisplayable) {
        vc.setOutlets(data: self.dataSet, attribution: self.attribution)
    }
    
    func openMoreInfoLink() {
        let appDelegate = UIApplication.shared
        guard let urls = dataSet.urls else {
            return
        }
        for urlPath in urls {
            guard urlPath.url.isEmpty == false, let url = URL(string: urlPath.url) else {
                continue
            }
            if appDelegate.canOpenURL(url) {
                appDelegate.open(url)
                return
            }
        }
    }
}
