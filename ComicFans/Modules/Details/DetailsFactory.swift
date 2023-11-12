//
//  DetailsFactory.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/11/23.
//

final class DetailsFactory {
    func makeCoordinator(dataSet: DataSet, attribution: String?) -> DetailsCoordinator {
        return DetailsCoordinator(dataSet: dataSet, attribution: attribution)
    }
    
    func makeMediatingController(delegate: DetailsCoordinator) -> DetailsMediatingController {
        return DetailsMediatingController(delegate: delegate)
    }
}
