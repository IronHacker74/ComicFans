//
//  TriviaCollectionViewQuestionCard.swift
//  ComicFans
//
//  Created by Andrew Masters on 12/1/23.
//

import UIKit

final class TriviaCollectionViewQuestionCard: UIView {
    @IBOutlet private (set) var questionLabel: UILabel!
    
    func setupQuestionCard(question: String?) {
        self.backgroundColor = .mediumBlue()
        self.questionLabel.text = question
    }
}
