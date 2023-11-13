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
}
