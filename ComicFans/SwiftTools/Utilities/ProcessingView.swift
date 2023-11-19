//
//  ProcessingView.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/13/23.
//

import UIKit

protocol ProcessingView {
    func beginProcessing()
    func finishProcessing()
}

extension ProcessingView {
    func beginProcessing(_ view: UIView) {
        let activityView = UIActivityIndicatorView()
        activityView.center = view.center
        view.addSubview(activityView)
    }
    
    func finishProcessing(_ view: UIView) {
        guard let activityView = view.subviews.first(where: {$0 is UIActivityIndicatorView}) else {
            return
        }
        activityView.removeFromSuperview()
    }
}
