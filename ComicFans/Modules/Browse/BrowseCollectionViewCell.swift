//
//  BrowseCollectionViewCell.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import UIKit

final class BrowseCollectionViewCell: UICollectionViewCell, UIViewLoading {
    @IBOutlet weak var browseBackgroundView: ShadowView!
    @IBOutlet weak var browseImage: UIImageView!
    @IBOutlet weak var browseTitle: UILabel!
    @IBOutlet weak var browseDescription: UILabel!
    
    func configureCell(imageURL: String?, title: String?, description: String?) {
        self.browseTitle.text = title
        self.browseDescription.text = description
        if let imagePath = imageURL {
            self.browseImage.downloaded(from: imagePath, contentMode: .scaleAspectFill)
        }
    }
}
