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
    
    func configureCell(event: DataSet) {
        self.backgroundColor = .clear
        self.eventBackground.backgroundColor = .marvelRed()
        self.titleLabel.text = event.title
        self.descriptionLabel.text = event.description
    }
    
    func configureImage(image: UIImage?, imagePath: String?, completion: @escaping (UIImage?) -> Void) {
        if let image {
            self.eventImage.image = image
            completion(nil)
            return
        }
        if let imagePath {
            self.eventImage.downloaded(from: imagePath, completion: completion)
            return
        }
        completion(nil)
    }
}
