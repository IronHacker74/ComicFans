//
//  TriviaCollectionViewCard.swift
//  ComicFans
//
//  Created by Andrew Masters on 12/1/23.
//

import UIKit

final class TriviaCollectionViewCard: UICollectionViewCell {
    @IBOutlet private (set) var cardView: UIView!
    private let questionCard: TriviaCollectionViewQuestionCard = TriviaCollectionViewQuestionCard.initFromNib()
    private let answerCard: TriviaCollectionViewAnswerCard = TriviaCollectionViewAnswerCard.initFromNib()
    private var currentCardState: Bool = false // false is question, true is answer

    func configureCell(dataset: DataSet) {
        self.removeSubviews()
        self.cardView.addSubview(self.questionCard)
        self.questionCard.setupQuestionCard(question: dataset.description)
        self.answerCard.setupAnswerCard(urlImagePath: dataset.thumbnail?.fullPath, answer: dataset.getTitle())
    }
    
    func cardViewTapped() {
        if self.currentCardState {
            UIView.transition(from: self.answerCard, to: self.questionCard, duration: 0.5, options: .transitionFlipFromLeft, completion: nil)
        } else {
            self.answerCard.downloadImageIfNecessary()
            UIView.transition(from: self.questionCard, to: self.answerCard, duration: 0.5, options: .transitionFlipFromRight, completion: nil)
        }
        self.currentCardState.toggle()
    }
    
    private func removeSubviews() {
        for subview in self.cardView.subviews {
            subview.removeFromSuperview()
        }
    }
}
