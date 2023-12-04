//
//  TriviaCollectionViewCard.swift
//  ComicFans
//
//  Created by Andrew Masters on 12/1/23.
//

import UIKit

final class TriviaCollectionViewCard: UICollectionViewCell {
    @IBOutlet private (set) var cardView: UIView!
    private var questionCard: TriviaCollectionViewQuestionCard?
    private var answerCard: TriviaCollectionViewAnswerCard?
    private var currentCardState: Bool = false // false is question, true is answer

    func configureCell(dataset: DataSet) {
        self.questionCard = TriviaCollectionViewQuestionCard.initFromNib()
        self.questionCard?.setupQuestionCard(question: dataset.description)
        self.answerCard = TriviaCollectionViewAnswerCard.initFromNib()
        self.answerCard?.setupAnswerCard(urlImagePath: dataset.thumbnail?.fullPath, answer: dataset.getTitle())
        if let questionCard {
            self.cardView.addSubview(questionCard)
            self.answerCard?.frame = self.frame
        }
    }
    
    func cardViewTapped() {
        guard let answerCard, let questionCard else { return }
        if self.currentCardState {
            UIView.transition(from: answerCard, to: questionCard, duration: 0.5, options: .transitionFlipFromLeft, completion: nil)
        } else {
            self.answerCard?.downloadImageIfNecessary()
            UIView.transition(from: questionCard, to: answerCard, duration: 0.5, options: .transitionFlipFromRight, completion: nil)
        }
        self.currentCardState.toggle()
    }
}
