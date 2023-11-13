//
//  DetailsTableViewCell.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/11/23.
//

import UIKit

final class DetailsTableViewCell: UITableViewCell {
    @IBOutlet private (set) var label: UILabel!
    
    func configureCell(text: String?) {
        self.backgroundColor = .clear
        self.label.text = text
    }
}
