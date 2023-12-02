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
    
    func setupAnswerCard(urlImagePath: String?, answer: String?) {
        self.answerTitle.text = answer
        if let urlImagePath {
            self.answerImage.downloaded(from: urlImagePath, completion: {_ in})
        }
    }

}
