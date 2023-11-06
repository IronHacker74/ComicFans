//
//  OpenAppLink.swift
//  Created by Andrew Masters on 7/27/23.
//

import UIKit

enum AppLinks: String {
    // TODO: add your links here
    case example = "https://example.com"
}

class OpenLink {
    static func using(_ applink: AppLinks, vc: UIViewController) {
        guard let url = URL(string: applink.rawValue) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

