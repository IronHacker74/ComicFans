//
//  CurrentEventCell.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import UIKit

final class CurrentEventCell: UITableViewCell {
    @IBOutlet weak var eventBackground: ShadowView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(event: Event) {
        self.titleLabel.text = event.title
        self.descriptionLabel.text = event.description
        self.eventImage.downloaded(from: event.thumbnail.fullPath)
    }
}
