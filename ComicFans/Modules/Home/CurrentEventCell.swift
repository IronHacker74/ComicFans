//
//  CurrentEventCell.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import UIKit

final class CurrentEventCell: UITableViewCell, UIViewLoading {
    @IBOutlet weak var eventBackground: ShadowView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(event: Event) {
        self.titleLabel.text = event.title
        self.descriptionLabel.text = event.description
        if let imagePath = event.thumbnail?.fullPath {
            self.eventImage.downloaded(from: imagePath)
        }
    }
}
