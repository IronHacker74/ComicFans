//
//  PadConstraints.swift
//  ComicFans
//
//  Created by Andrew Masters on 2/5/24.
//

import UIKit

protocol PadConstraints {
    var padConstraints: [NSLayoutConstraint] { get set }
    func setPadConstraints(size: CGSize)
}

extension PadConstraints {
    func setPadConstraints(size: CGSize) {
        guard UIDevice.current.userInterfaceIdiom == .pad else { return }
        for constraint in self.padConstraints {
            constraint.constant = size.width/8
        }
    }
}
