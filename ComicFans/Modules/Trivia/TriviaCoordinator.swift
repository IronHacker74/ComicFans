//
//  TriviaCoordinator.swift
//  ComicFans
//
//  Created by Andrew Masters on 12/1/23.
//

import Foundation

final class TriviaCoordinator: TriviaDelegate {
    private let request: TriviaRequest
    private let limit: Int = 60
    private let triviaQuestionsLimit: Int = 10
    
    init(request: TriviaRequest) {
        self.request = request
    }
    
    func triviaMediatingControllerViewDidLoad(_ vc: TriviaDisplayable) {
        // TODO: get a mixture of characters and comics
        self.getTotalNumberOfCharacters(completion: { total, error in
            guard error == nil, let total else {
                // TODO: show error
                return
            }
            let randomCharacterStart = Int.random(in: 1...(total - self.limit) )
            self.fetchCharactersForTrivia(vc: vc, offset: randomCharacterStart)
        })
    }
    
    private func fetchCharactersForTrivia(vc: TriviaDisplayable, offset: Int) {
        self.request.getCharacters(limit: self.limit, offset: offset, completion: { dataset, _, attributionText, error in
            DispatchQueue.main.async {
                guard error == nil, let dataset else {
                    // TODO: show error
                    return
                }
                self.processFetchedCharacters(vc: vc, dataset: dataset, attributionText: attributionText)
            }
        })
    }
    
    private func processFetchedCharacters(vc: TriviaDisplayable, dataset: [DataSet], attributionText: String?) {
        var triviaQuestions: [DataSet] = []
        for dataItem in dataset {
            if let description = dataItem.description, !description.isEmpty {
                triviaQuestions.append(dataItem)
            }
            if triviaQuestions.count >= self.triviaQuestionsLimit {
                break
            }
        }
        vc.updateTriviaData(triviaQuestions, attributionText: attributionText)
    }
    
    private func getTotalNumberOfCharacters(completion: @escaping (Int?, Error?) -> (Void)) {
        self.request.getCharacters(limit: 1, offset: 0, completion: { _, total, attributionText, error in
            completion(total, error)
        })
    }
}
