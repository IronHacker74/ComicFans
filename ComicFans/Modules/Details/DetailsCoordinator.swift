//
//  DetailsCoordinator.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/11/23.
//

import UIKit

final class DetailsCoordinator: DetailsDelegate {
    private let detailsRequest: DetailsRequest?
    private let detailsURLPath: String?
    private var dataSet: DataSet?
    private var attribution: String?
    private let navigator: UINavigationController?
    
    init(dataSet: DataSet?, attribution: String?, detailsRequest: DetailsRequest?, detailsURLPath: String?, navigator: UINavigationController?) {
        self.dataSet = dataSet
        self.attribution = attribution
        self.detailsRequest = detailsRequest
        self.detailsURLPath = detailsURLPath
        self.navigator = navigator
    }
    
    func detailsMediatingControllerViewDidLoad(_ vc: DetailsDisplayable) {
        if let dataSet {
            vc.setOutlets(data: dataSet, attribution: self.attribution)
        } else if let detailsRequest, let detailsURLPath {
            vc.beginProcessing()
            detailsRequest.getDetails(urlpath: detailsURLPath, completion: { details, attributionText, error in
                DispatchQueue.main.async {
                    vc.finishProcessing()
                    guard let details, error == nil else {
                        vc.presentErrorAlert()
                        return
                    }
                    self.dataSet = details
                    self.attribution = attributionText
                    vc.setOutlets(data: details, attribution: attributionText)
                }
            })
        }
    }
    
    func detailsMediatingControllerDidSelectRow(detailsPath: String) {
        let factory = DetailsFactory()
        let coordinator = factory.makeCoordinator(dataSet: nil, attribution: nil, detailsPath: detailsPath, navigator: self.navigator)
        let controller = factory.makeMediatingController(delegate: coordinator)
        self.navigator?.pushViewController(controller, animated: true)
    }
    
    func shareInfoLink() {
        guard let urls = dataSet?.urls else {
            return
        }
        for urlPath in urls {
            guard urlPath.url.isEmpty == false, let url = URL(string: urlPath.url) else {
                continue
            }
            if UIApplication.shared.canOpenURL(url) {
                let controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                let topView = self.navigator?.topViewController?.view
                controller.popoverPresentationController?.sourceView = topView
                controller.popoverPresentationController?.sourceRect = topView?.frame ?? .zero
                self.navigator?.present(controller, animated: true)
                break
            }
        }
    }
}
