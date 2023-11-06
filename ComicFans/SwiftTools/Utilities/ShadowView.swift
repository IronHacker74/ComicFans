//
//  ShadowView.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/5/23.
//

import UIKit

protocol ShadowViewDelegate: UIView {
    func addShadow()
}

extension UIView {
    func addShadow() {
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.black.cgColor
    }
}

class ShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow()
    }
}
