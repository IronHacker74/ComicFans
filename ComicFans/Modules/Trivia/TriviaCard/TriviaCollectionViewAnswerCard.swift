//
//  TriviaCollectionViewAnswerCard.swift
//  ComicFans
//
//  Created by Andrew Masters on 12/1/23.
//

import UIKit

final class TriviaCollectionViewAnswerCard: UIView {
    @IBOutlet private (set) var answerImage: UIImageView!
    @IBOutlet private (set) var answerTitle: UILabel!
    private var urlImagePath: String? = nil
    
    func setupAnswerCard(urlImagePath: String?, answer: String?) {
        self.answerTitle.text = answer
        self.urlImagePath = urlImagePath
        self.downloadImageIfNecessary()
    }

    func downloadImageIfNecessary() {
        guard let urlImagePath, self.answerImage.image == nil else { return }
        self.answerImage.downloaded(from: urlImagePath, contentMode: .scaleAspectFill, completion: {_ in})
    }
}
